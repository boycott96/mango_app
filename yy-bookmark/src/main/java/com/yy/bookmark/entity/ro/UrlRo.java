package com.yy.bookmark.entity.ro;

import com.yy.common.core.constant.ExceptionConstants;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

/**
 * @author sunruiguang
 * @date 2023-04-28
 */
@Getter
@Setter
@NoArgsConstructor
public class UrlRo {

    /**
     * 书签名称
     */
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    private String name;

    /**
     * 书签地址
     */
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    private String address;

    /**
     * 书签描述
     */
    private String description;

    /**
     * 书签icon
     */
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    private String favicon;
}
