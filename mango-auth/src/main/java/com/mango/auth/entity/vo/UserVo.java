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

    private String openId;

    private String username;

    private String avatarUrl;
}
