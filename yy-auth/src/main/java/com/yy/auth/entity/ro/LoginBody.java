package com.yy.auth.entity.ro;

import com.yy.common.core.constant.ExceptionConstants;
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
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    private String username;


    /**
     * 密码
     */
    @NotNull(message = ExceptionConstants.PARAM_INVALID)
    private String password;
}
