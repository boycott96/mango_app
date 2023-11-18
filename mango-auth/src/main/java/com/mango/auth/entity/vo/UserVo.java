package com.mango.auth.entity.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

/**
 * @author sunruiguang
 * @date 2022-11-29
 */
@Getter
@Setter
@AllArgsConstructor
public class UserVo {

    private String email;

    private String username;

    private String stageName;

    private String avatarUrl;
}
