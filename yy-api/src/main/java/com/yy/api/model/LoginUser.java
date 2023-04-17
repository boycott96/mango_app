package com.yy.api.model;

import com.yy.api.entity.AuthUser;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 用户信息
 *
 * @author sunruiguang
 */
@Data
public class LoginUser implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户唯一标识
     */
    private String token;

    /**
     * 用户名id
     */
    private Long id;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 账户名
     */
    private String account;

    /**
     * 用户名
     */
    private String username;

    /**
     * 登录时间
     */
    private Long loginTime;

    /**
     * 过期时间
     */
    private Long expireTime;

    /**
     * 用户信息
     */
    private AuthUser authUser;
}
