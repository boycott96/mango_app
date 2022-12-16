package com.yy.common.security.auth;

import com.yy.api.model.LoginUser;
import com.yy.common.core.utils.SpringUtils;
import com.yy.common.security.service.TokenService;

/**
 * Token 权限验证
 *
 * @author sunruiguang
 * @date 2022-10-21
 */
public class AuthLogic {

    public TokenService tokenService = SpringUtils.getBean(TokenService.class);

    /**
     * 会话注销，根据指定Token
     */
    public void logoutByToken(String token) {
        tokenService.delLoginUser(token);
    }

    /**
     * 获取当前用户缓存信息, 如果未登录，则抛出异常
     *
     * @return 用户缓存信息
     */
    public LoginUser getLoginUser(String token) {
        return tokenService.getLoginUser(token);
    }

    public void verifyLoginUserExpire(LoginUser loginUser) {
        tokenService.verifyToken(loginUser);
    }
}
