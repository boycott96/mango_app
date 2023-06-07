package com.yy.bookmark.entity.ro;

import com.yy.common.core.constant.ExceptionConstants;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * @author sunruiguang
 * @date 2023-05-09
 */
@Getter
@Setter
@NoArgsConstructor
public class CollectUrlRo {

    /**
     * 文件夹ID
     */
    private Long folderId;

    /**
     * 链接别名
     */
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    private String aliasAddress;

    /**
     * 图标
     */
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    private String favicon;

    /**
     * 描述
     */
    @Size(max = 500, message = ExceptionConstants.PARAM_INVALID)
    private String description;

    /**
     * 链接名称
     */
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    @Size(max = 50, message = ExceptionConstants.PARAM_INVALID)
    private String urlName;
}
