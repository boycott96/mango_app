package com.mango.common.security.auth;

import com.mango.api.model.LoginUser;

/**
 * @author sunruiguang
 * @date 2022-10-22
 */
public class AuthUtil {
    public static AuthLogic authLogic = new AuthLogic();

    /**
     * 会话注销，根据指定Token
     *
     * @param token 指定token
     */
    public static void logoutByToken(String token) {
        authLogic.logoutByToken(token);
    }

    public static LoginUser getLoginUser(String token) {
        return authLogic.getLoginUser(token);
    }

    public static void verifyLoginUserExpire(LoginUser loginUser) {
        authLogic.verifyLoginUserExpire(loginUser);
    }
}
