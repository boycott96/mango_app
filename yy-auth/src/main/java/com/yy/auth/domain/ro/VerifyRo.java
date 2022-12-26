package com.yy.auth.domain.ro;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * @author sunruiguang
 * @date 2022-12-23
 */
@Getter
@Setter
@NoArgsConstructor
public class VerifyRo {

    private String email;

    private String verifyCode;
}
