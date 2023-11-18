package com.mango.auth.entity.ro;

import com.mango.auth.entity.vo.UserVo;
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
    private UserVo user;
}
