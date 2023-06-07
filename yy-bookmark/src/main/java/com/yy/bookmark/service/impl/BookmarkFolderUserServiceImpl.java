package com.yy.bookmark.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.bookmark.entity.po.BookmarkFolderUser;
import com.yy.bookmark.mapper.BookmarkFolderUserMapper;
import com.yy.bookmark.service.BookmarkFolderUserService;
import org.springframework.stereotype.Service;

/**
 * @author sunruiguang
 * @since 2023/5/6
 */
@Service
public class BookmarkFolderUserServiceImpl extends ServiceImpl<BookmarkFolderUserMapper, BookmarkFolderUser> implements BookmarkFolderUserService {

    private final BookmarkFolderUserMapper bookmarkFolderUserMapper;

    public BookmarkFolderUserServiceImpl(BookmarkFolderUserMapper bookmarkFolderUserMapper) {
        this.bookmarkFolderUserMapper = bookmarkFolderUserMapper;
    }

    @Override
    public Long getMaxSortByUserId(Long userId) {
        LambdaQueryWrapper<BookmarkFolderUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(BookmarkFolderUser::getUserId, userId);
        queryWrapper.select(BookmarkFolderUser::getFolderSort).last("LIMIT 1");
        BookmarkFolderUser bookmarkFolderUser = bookmarkFolderUserMapper.selectOne(queryWrapper);
        return bookmarkFolderUser.getFolderSort();
    }
}
