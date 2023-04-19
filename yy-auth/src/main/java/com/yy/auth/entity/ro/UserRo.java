package com.yy.auth.entity.ro;

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
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    @Email(message = ExceptionConstants.PARAM_INVALID)
    private String email;

    /**
     * 账户
     */
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    @Size(min = 3, max = 20, message = ExceptionConstants.PARAM_LENGTH_INVALID)
    private String username;

    /**
     * 姓名
     */
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    @Size(min = 1, max = 50, message = ExceptionConstants.PARAM_LENGTH_INVALID)
    private String stageName;

    /**
     * 密码
     */
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    @Size(min = 5, max = 50, message = ExceptionConstants.PARAM_LENGTH_INVALID)
    private String password;

    /**
     * 验证码
     */
    private String verifyCode;
}
