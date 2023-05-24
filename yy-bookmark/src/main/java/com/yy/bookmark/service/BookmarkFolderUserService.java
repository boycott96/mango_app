package com.yy.bookmark.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.yy.bookmark.entity.po.BookmarkFolderUser;

public interface BookmarkFolderUserService extends IService<BookmarkFolderUser> {

    /**
     * 查询用户文件夹关联表最大的排序值
     *
     * @param userId 用户ID
     * @return java.lang.Long
     * @author sunruiguang
     * @since 2023/5/23
     */
    Long getMaxSortByUserId(Long userId);
}
