package com.yy.bookmark.entity.ro;

import com.yy.common.core.constant.ExceptionConstants;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * @author sunruiguang
 * @date 2023-04-27
 */
@Getter
@Setter
@NoArgsConstructor
public class FolderRo {

    @NotNull(message = ExceptionConstants.PARAM_INVALID)
    private Long id;

    @NotBlank(message = ExceptionConstants.PARAM_INVALID)
    @Size(max = 12, message = ExceptionConstants.PARAM_LENGTH_INVALID)
    private String name;
}
