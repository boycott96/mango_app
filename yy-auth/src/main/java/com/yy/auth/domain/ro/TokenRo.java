package com.yy.auth.domain.ro;

import lombok.*;

/**
 * @author sunruiguang
 * @date 2022-12-10
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TokenRo {

    /**
     * 访问钥匙
     */
    private String accessToken;

    /**
     * 过期时间
     */
    private long expiresIn;
}
