package com.yy.bookmark.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.bookmark.entity.po.BookmarkFolder;
import com.yy.bookmark.mapper.BookmarkFolderMapper;
import com.yy.bookmark.service.BookmarkFolderService;
import org.springframework.stereotype.Service;

/**
 * @author sunruiguang
 * @date 2023-05-06
 */
@Service
public class BookmarkFolderServiceImpl extends ServiceImpl<BookmarkFolderMapper, BookmarkFolder> implements BookmarkFolderService {
}
