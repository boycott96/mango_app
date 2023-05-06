package com.yy.bookmark.entity.ro;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * @author sunruiguang
 * @date 2023-05-06
 */
@Getter
@Setter
@NoArgsConstructor
public class BookmarkUrlRo extends UrlRo{

    /**
     * 文件夹ID
     */
    private Long folderId;
}
