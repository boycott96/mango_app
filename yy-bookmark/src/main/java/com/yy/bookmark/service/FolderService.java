package com.yy.bookmark.service;

import com.yy.bookmark.entity.po.BookmarkFolder;

/**
 * @author sunruiguang
 * @date 2023-04-27
 */
public interface FolderService {

    /**
     * 创建文件夹数据
     *
     * @param id   用户id
     * @param name 文件夹名称
     * @author sunruiguang
     * @since 2023/4/27
     */
    void createFolder(Long id, String name);

    /**
     * 更新书签文件夹数据
     *
     * @param bookmarkFolder 文件夹数据
     * @author sunruiguang
     * @since 2023/4/27
     */
    void updateFolder(BookmarkFolder bookmarkFolder);
}
