package com.yy.auth.entity.ro;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author sunruiguang
 * @date 2022-11-17
 */
@Data
public class LoginBody {

    /**
     * 用户名
     */
    @NotBlank(message = "邮箱不能为空")
    private String email;

    /**
     * 密码
     */
    @NotNull(message = "密码不能为空")
    private String password;
}
