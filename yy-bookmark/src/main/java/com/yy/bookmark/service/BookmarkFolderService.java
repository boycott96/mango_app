package com.yy.bookmark.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.yy.bookmark.entity.po.BookmarkFolder;
import com.yy.bookmark.entity.ro.FolderUrlRo;

import java.util.List;

/**
 * @author sunruiguang
 * @date 2023-04-28
 */
public interface BookmarkFolderService extends IService<BookmarkFolder> {


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

    /**
     * 删除文件夹数据
     *
     * @param userId   用户ID
     * @param folderId 文件夹ID
     * @author sunruiguang
     * @since 2023/4/28
     */
    void deleteById(Long userId, Long folderId);

    /**
     * 批量插入
     *
     * @param userId 用户ID
     * @param folderUrlRos 文件夹书签数据
     * @author sunruiguang
     * @since 2023/4/28
     */
    void batchAdd(Long userId, List<FolderUrlRo> folderUrlRos);
}
