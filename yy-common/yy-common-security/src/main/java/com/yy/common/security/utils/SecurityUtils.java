package com.yy.common.security.utils;

import com.yy.api.model.LoginUser;
import com.yy.common.core.constant.SecurityConstants;
import com.yy.common.core.constant.TokenConstants;
import com.yy.common.core.context.SecurityContextHolder;
import com.yy.common.core.utils.ServletUtils;
import com.yy.common.core.utils.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Objects;

/**
 * 权限获取工具类
 *
 * @author sunruiguang
 * @date 2022-10-22
 */
public class SecurityUtils {

    public static Long getUserId() {
        return SecurityContextHolder.getUserId();
    }

    /**
     * 获取用户名称
     */
    public static String getUsername() {
        return SecurityContextHolder.getUserName();
    }

    /**
     * 获取用户key
     */
    public static String getUserKey() {
        return SecurityContextHolder.getUserKey();
    }

    /**
     * 获取登录用户信息
     */
    public static LoginUser getLoginUser() {
        return SecurityContextHolder.get(SecurityConstants.LOGIN_USER, LoginUser.class);
    }

    /**
     * 获取请求token
     */
    public static String getToken() {
        return getToken(Objects.requireNonNull(ServletUtils.getRequest()));
    }

    /**
     * 根据request获取请求token
     */
    public static String getToken(HttpServletRequest request) {
        // 从header获取token标识
        String token = request.getHeader(TokenConstants.AUTHENTICATION);
        return replaceTokenPrefix(token);
    }

    /**
     * 裁剪token前缀
     */
    public static String replaceTokenPrefix(String token) {
        // 如果前端设置了令牌前缀，则裁剪掉前缀
        if (StringUtils.isNotEmpty(token) && token.startsWith(TokenConstants.PREFIX)) {
            token = token.replaceFirst(TokenConstants.PREFIX, "");
        }
        return token;
    }
}
