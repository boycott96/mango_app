package com.yy.auth.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author sunruiguang
 * @date 2023-05-26
 */
@Data
@NoArgsConstructor
public class AuthLotto {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String number;

    private Integer countNum;

    public AuthLotto(String number) {
        this.number = number;
    }
}
