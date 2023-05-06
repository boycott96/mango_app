package com.yy.bookmark.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.bookmark.entity.po.BookmarkFolderUrl;
import com.yy.bookmark.entity.po.BookmarkUrl;
import com.yy.bookmark.entity.ro.BookmarkUrlRo;
import com.yy.bookmark.entity.ro.EditFolderUrlRo;
import com.yy.bookmark.mapper.BookmarkUrlMapper;
import com.yy.bookmark.service.BookmarkFolderUrlService;
import com.yy.bookmark.service.BookmarkUrlService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.exception.ServiceException;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Objects;

/**
 * @author sunruiguang
 * @date 2023-05-06
 */
@Service
public class BookmarkUrlServiceImpl extends ServiceImpl<BookmarkUrlMapper, BookmarkUrl> implements BookmarkUrlService {

    private final BookmarkFolderUrlService bookmarkFolderUrlService;

    public BookmarkUrlServiceImpl(BookmarkFolderUrlService bookmarkFolderUrlService) {
        this.bookmarkFolderUrlService = bookmarkFolderUrlService;
    }

    @Override
    public void addBookmarkUrl(Long userId, BookmarkUrlRo urlRo) {

        // todo 对同一个域名下的网址进行数据统一
        BookmarkUrl bookmarkUrl = new BookmarkUrl();
        BeanUtils.copyProperties(urlRo, bookmarkUrl);
        bookmarkUrl.setCreateBy(userId);
        Date date = new Date();
        bookmarkUrl.setCreateTime(date);
        this.save(bookmarkUrl);
        if (Objects.nonNull(urlRo.getFolderId())) {
            // 插入文件夹和书签链接的关联属性
            BookmarkFolderUrl bookmarkFolderUrl = new BookmarkFolderUrl(urlRo.getFolderId(), bookmarkUrl.getId(), userId, date);
            bookmarkFolderUrlService.save(bookmarkFolderUrl);
        }
    }

    @Override
    public void updateBookmarkUrl(Long userId, EditFolderUrlRo urlRo) {
        // 先查询对应的URL数据，是否存在
        BookmarkUrl bookmarkUrl = this.getById(urlRo.getId());
        ServiceException.isTrue(Objects.isNull(bookmarkUrl), ExceptionConstants.NOT_FOUND_DATA);
        BeanUtils.copyProperties(urlRo, bookmarkUrl);
        this.updateById(bookmarkUrl);
        if (Objects.nonNull(urlRo.getFolderId())) {
            // todo 根据URL ID 和文件夹ID进行关联

        }
    }
}
