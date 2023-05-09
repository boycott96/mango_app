package com.yy.bookmark.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.yy.bookmark.entity.po.BookmarkUrl;
import com.yy.bookmark.entity.ro.BookmarkUrlRo;
import com.yy.bookmark.entity.ro.EditFolderUrlRo;

public interface BookmarkUrlService extends IService<BookmarkUrl> {

    /**
     * 添加书签
     *
     * @param userId 用户ID
     * @param urlRo  url请求参数
     * @author sunruiguang
     * @since 2023/5/6
     */
    void addBookmarkUrl(Long userId, BookmarkUrlRo urlRo);

    /**
     * 更新书签URL
     *
     * @param userId 用户ID
     * @param urlRo  url请求参数
     * @author sunruiguang
     * @since 2023/5/6
     */
    void updateBookmarkUrl(Long userId, EditFolderUrlRo urlRo);

    /**
     * 删除书签
     *
     * @param userId 用户ID
     * @param urlId  urlID
     * @author sunruiguang
     * @since 2023/5/9
     */
    void deleteBookmarkUrl(Long userId, Long urlId);
}
