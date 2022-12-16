package com.yy.auth.domain.enums;

import com.yy.common.core.constant.ExceptionConstants;
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
    PHONE_CHECK(1, "phone_number", ExceptionConstants.PHONE_NOT_UNIQUE),
    EMAIL_CHECK(2, "email", ExceptionConstants.EMAIL_NOT_UNIQUE),
    USERNAME_CHECK(3, "username", ExceptionConstants.USERNAME_NOT_UNIQUE);
    private final int code;

    private final String fieldName;

    private final String msg;

    public static CheckUniqueTypeEnum ofCode(int code) {
        return Arrays.stream(CheckUniqueTypeEnum.values())
                .collect(Collectors.toMap(CheckUniqueTypeEnum::getCode, Function.identity())).get(code);
    }
}
