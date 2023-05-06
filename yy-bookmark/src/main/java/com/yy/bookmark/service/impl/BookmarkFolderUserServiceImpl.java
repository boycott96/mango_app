package com.yy.bookmark.service.impl;

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
}
