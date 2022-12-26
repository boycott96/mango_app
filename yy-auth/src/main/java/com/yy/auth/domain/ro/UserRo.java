package com.yy.auth.domain.ro;

import com.yy.common.core.constant.ExceptionConstants;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * @author sunruiguang
 * @date 2022-11-14
 */
@Data
public class UserRo {

    /**
     * 邮箱地址
     */
    @Email(message = ExceptionConstants.EMAIL_INVALID)
    private String email;

    /**
     * 用户名
     */
    @NotBlank(message = ExceptionConstants.USERNAME_INVALID)
    @Size(min = 1, max = 50, message = ExceptionConstants.USERNAME_LENGTH_INVALID)
    private String username;

    /**
     * 密码
     */
    @NotBlank(message = ExceptionConstants.PWD_INVALID)
    @Size(min = 1, max = 50, message = ExceptionConstants.PWD_LENGTH_INVALID)
    private String password;

    private String verifyCode;
}
