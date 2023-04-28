package com.yy.bookmark.entity.ro;

import com.yy.common.core.constant.ExceptionConstants;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.List;

/**
 * @author sunruiguang
 * @date 2023-04-28
 */
@Getter
@Setter
@NoArgsConstructor
public class FolderUrlRo {

    // 文件夹名称
    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    @Size(max = 12, message = ExceptionConstants.PARAM_LENGTH_INVALID)
    private String name;

    // 书签集合
    private List<UrlRo> urlList;
}
