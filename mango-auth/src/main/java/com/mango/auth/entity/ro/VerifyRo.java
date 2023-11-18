package com.mango.auth.entity.ro;

import com.mango.common.core.constant.ExceptionConstants;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

/**
 * @author sunruiguang
 * @date 2022-12-23
 */
@Getter
@Setter
@NoArgsConstructor
public class VerifyRo {

    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    private String email;

    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    private String verifyCode;
}
