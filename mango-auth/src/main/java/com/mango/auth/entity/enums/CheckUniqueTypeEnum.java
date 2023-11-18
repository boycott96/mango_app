package com.mango.auth.entity.enums;

import com.mango.common.core.constant.ExceptionConstants;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * 检查唯一性的枚举类
 *
 * @author sunruiguang
 */
@AllArgsConstructor
@Getter
public enum CheckUniqueTypeEnum {
    EMAIL_CHECK(1, "email", ExceptionConstants.EMAIL_NOT_UNIQUE),
    USERNAME_CHECK(2, "username", ExceptionConstants.USERNAME_NOT_UNIQUE);
    private final int code;

    private final String fieldName;

    private final String msg;

    public static CheckUniqueTypeEnum ofCode(int code) {
        return Arrays.stream(CheckUniqueTypeEnum.values())
                .collect(Collectors.toMap(CheckUniqueTypeEnum::getCode, Function.identity())).get(code);
    }
}
