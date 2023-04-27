package com.yy.bookmark.service.impl;

import com.yy.bookmark.entity.po.BookmarkFolder;
import com.yy.bookmark.entity.po.BookmarkFolderUser;
import com.yy.bookmark.mapper.BookmarkFolderMapper;
import com.yy.bookmark.service.BookmarkFolderUserService;
import com.yy.bookmark.service.FolderService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.exception.ServiceException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Objects;

/**
 * @author sunruiguang
 * @date 2023-04-27
 */
@Service
public class FolderServiceImpl implements FolderService {

    private final BookmarkFolderMapper bookmarkFolderMapper;
    private final BookmarkFolderUserService bookmarkFolderUserService;

    public FolderServiceImpl(BookmarkFolderMapper bookmarkFolderMapper,
                             BookmarkFolderUserService bookmarkFolderUserService) {
        this.bookmarkFolderMapper = bookmarkFolderMapper;
        this.bookmarkFolderUserService = bookmarkFolderUserService;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void createFolder(Long id, String name) {
        // 插入书签文件夹数据
        BookmarkFolder bookmarkFolder = new BookmarkFolder();
        bookmarkFolder.setName(name);
        bookmarkFolder.setCreateBy(id);
        Date date = new Date();
        bookmarkFolder.setCreateTime(date);
        bookmarkFolderMapper.insert(bookmarkFolder);
        // 插入关联表
        BookmarkFolderUser bookmarkFolderUser = new BookmarkFolderUser();
        bookmarkFolderUser.setFolderId(bookmarkFolderUser.getFolderId());
        bookmarkFolderUser.setUserId(id);
        bookmarkFolderUser.setType(false);
        bookmarkFolderUser.setCreateTime(date);
        bookmarkFolderUserService.save(bookmarkFolderUser);
    }

    @Override
    public void updateFolder(BookmarkFolder bookmarkFolder) {
        // 先查询对应的书签文件夹数据
        BookmarkFolder entity = bookmarkFolderMapper.selectById(bookmarkFolder.getId());
        ServiceException.isTrue(Objects.isNull(entity), ExceptionConstants.NOT_FOUND_DATA);
        entity.setName(bookmarkFolder.getName());
        entity.setUpdateTime(new Date());
        bookmarkFolderMapper.updateById(entity);
    }
}
