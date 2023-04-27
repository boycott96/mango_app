package com.yy.auth.service;

import com.yy.api.model.LoginUser;
import com.yy.auth.entity.ro.TokenRo;
import com.yy.auth.entity.vo.UserVo;
import com.yy.common.core.constant.CacheConstants;
import com.yy.common.core.constant.SecurityConstants;
import com.yy.common.core.utils.IdUtils;
import com.yy.common.core.utils.JwtUtils;
import com.yy.common.core.utils.ServletUtils;
import com.yy.common.core.utils.StringUtils;
import com.yy.common.redis.service.RedisService;
import com.yy.common.security.utils.SecurityUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * token验证处理
 *
 * @author yeyang
 */
@Service
@Slf4j
public class TokenService {
    private final RedisService redisService;

    protected static final long MILLIS_SECOND = 1000;

    protected static final long MILLIS_MINUTE = 60 * MILLIS_SECOND;

    private final static long expireTime = CacheConstants.EXPIRATION;

    private final static String ACCESS_TOKEN = CacheConstants.LOGIN_TOKEN_KEY;

    private final static Long MILLIS_MINUTE_TEN = CacheConstants.REFRESH_TIME * MILLIS_MINUTE;

    public TokenService(RedisService redisService) {
        this.redisService = redisService;
    }

    /**
     * 创建令牌
     */
    public TokenRo createToken(LoginUser loginUser, boolean remember) {
        String token = IdUtils.fastUUID();
        Long userId = loginUser.getAuthUser().getId();
        loginUser.setToken(token);
        loginUser.setId(userId);
        String email = loginUser.getAuthUser().getEmail();
        String stageName = loginUser.getAuthUser().getStageName();
        String username = loginUser.getAuthUser().getUsername();
        loginUser.setUsername(username);
        loginUser.setEmail(email);
        refreshToken(loginUser);

        // Jwt存储信息
        Map<String, Object> claimsMap = new HashMap<>();
        claimsMap.put(SecurityConstants.USER_KEY, token);
        claimsMap.put(SecurityConstants.DETAILS_USER_ID, userId);
        claimsMap.put(SecurityConstants.DETAILS_EMAIL, email);
        claimsMap.put(SecurityConstants.DETAILS_STAGE_NAME, stageName);
        claimsMap.put(SecurityConstants.DETAILS_USERNAME, username);
        if (remember) {
            claimsMap.put(SecurityConstants.EXPIRE_TIME, new Date().getTime() + CacheConstants.REMEMBER_EXPIRATION * MILLIS_MINUTE);
        } else {
            claimsMap.put(SecurityConstants.EXPIRE_TIME, new Date().getTime() + expireTime * MILLIS_MINUTE);
        }

        // 接口返回信息
        return new TokenRo(JwtUtils.createToken(claimsMap), new UserVo(email, username, stageName, loginUser.getAuthUser().getAvatarUrl()));
    }

    /**
     * 获取用户身份信息
     *
     * @return 用户信息
     */
    public LoginUser getLoginUser() {
        return getLoginUser(ServletUtils.getRequest());
    }

    /**
     * 获取用户身份信息
     *
     * @return 用户信息
     */
    public LoginUser getLoginUser(HttpServletRequest request) {
        // 获取请求携带的令牌
        String token = SecurityUtils.getToken(request);
        return getLoginUser(token);
    }

    /**
     * 获取用户身份信息
     *
     * @return 用户信息
     */
    public LoginUser getLoginUser(String token) {
        try {
            if (StringUtils.isNotEmpty(token)) {
                String userKey = JwtUtils.getUserKey(token);
                return redisService.getCacheObject(getTokenKey(userKey));
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 设置用户身份信息
     */
    public void setLoginUser(LoginUser loginUser) {
        if (StringUtils.isNotNull(loginUser) && StringUtils.isNotEmpty(loginUser.getToken())) {
            refreshToken(loginUser);
        }
    }

    /**
     * 删除用户缓存信息
     */
    public void delLoginUser(String token) {
        if (StringUtils.isNotEmpty(token)) {
            String userKey = JwtUtils.getUserKey(token);
            redisService.deleteObject(getTokenKey(userKey));
        }
    }

    /**
     * 验证令牌有效期，相差不足120分钟，自动刷新缓存
     *
     * @param loginUser 登录用户
     */
    public void verifyToken(LoginUser loginUser) {
        long expireTime = loginUser.getExpireTime();
        long currentTime = System.currentTimeMillis();
        if (expireTime - currentTime <= MILLIS_MINUTE_TEN) {
            refreshToken(loginUser);
        }
    }

    /**
     * 刷新令牌有效期
     *
     * @param loginUser 登录信息
     */
    public void refreshToken(LoginUser loginUser) {
        loginUser.setLoginTime(System.currentTimeMillis());
        loginUser.setExpireTime(loginUser.getLoginTime() + expireTime * MILLIS_MINUTE);
        // 根据uuid将loginUser缓存
        String userKey = getTokenKey(loginUser.getToken());
        redisService.setCacheObject(userKey, loginUser, expireTime, TimeUnit.MINUTES);
    }

    private String getTokenKey(String token) {
        return ACCESS_TOKEN + token;
    }
}