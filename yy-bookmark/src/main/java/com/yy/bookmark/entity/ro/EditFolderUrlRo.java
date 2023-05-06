package com.yy.bookmark.entity.ro;

import com.yy.common.core.constant.ExceptionConstants;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotNull;

/**
 * @author sunruiguang
 * @date 2023-05-06
 */
@Getter
@Setter
@NoArgsConstructor
public class EditFolderUrlRo extends UrlRo {

    /**
     * 文件夹ID
     */
    private Long folderId;

    /**
     * 书签ID
     */
    @NotNull(message = ExceptionConstants.PARAM_INVALID)
    private Long id;
}
