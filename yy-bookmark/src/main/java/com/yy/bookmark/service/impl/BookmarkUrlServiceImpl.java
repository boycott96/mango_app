package com.yy.bookmark.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.bookmark.entity.po.BookmarkFolderUrl;
import com.yy.bookmark.entity.po.BookmarkLightningUrl;
import com.yy.bookmark.entity.po.BookmarkUrl;
import com.yy.bookmark.entity.ro.BookmarkUrlRo;
import com.yy.bookmark.entity.ro.EditFolderUrlRo;
import com.yy.bookmark.mapper.BookmarkUrlMapper;
import com.yy.bookmark.service.BookmarkFolderUrlService;
import com.yy.bookmark.service.BookmarkLightningUrlService;
import com.yy.bookmark.service.BookmarkUrlService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.exception.ServiceException;
import com.yy.common.core.utils.DomainUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.URISyntaxException;
import java.util.Date;
import java.util.Objects;

/**
 * @author sunruiguang
 * @date 2023-05-06
 */
@Service
@Slf4j
public class BookmarkUrlServiceImpl extends ServiceImpl<BookmarkUrlMapper, BookmarkUrl> implements BookmarkUrlService {

    private final BookmarkFolderUrlService bookmarkFolderUrlService;
    private final BookmarkLightningUrlService bookmarkLightningUrlService;

    public BookmarkUrlServiceImpl(BookmarkFolderUrlService bookmarkFolderUrlService,
                                  BookmarkLightningUrlService bookmarkLightningUrlService) {
        this.bookmarkFolderUrlService = bookmarkFolderUrlService;
        this.bookmarkLightningUrlService = bookmarkLightningUrlService;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addBookmarkUrl(Long userId, BookmarkUrlRo urlRo) {
        String domain;
        try {
            domain = DomainUtils.extractDomain(urlRo.getAddress());
        } catch (URISyntaxException e) {
            log.warn(e.getMessage());
            throw new ServiceException(ExceptionConstants.URL_VALID);
        }
        // 先查询数据库中是否已经存在对应的域名
        LambdaQueryWrapper<BookmarkUrl> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(BookmarkUrl::getAddress, urlRo.getAddress());
        BookmarkUrl bookmarkUrl = this.getOne(queryWrapper);
        Date date = new Date();
        if (Objects.isNull(bookmarkUrl)) {
            bookmarkUrl = new BookmarkUrl();
            bookmarkUrl.setAddress(domain);
            bookmarkUrl.setCreateBy(userId);
            bookmarkUrl.setCreateTime(date);
            this.save(bookmarkUrl);
        }

        if (Objects.nonNull(urlRo.getFolderId())) {
            // 插入文件夹和书签链接的关联属性
            BookmarkFolderUrl bookmarkFolderUrl = new BookmarkFolderUrl(urlRo.getFolderId(), bookmarkUrl.getId());
            bookmarkFolderUrl.setAliasAddress(urlRo.getAddress());
            bookmarkFolderUrl.setCreateBy(userId);
            bookmarkFolderUrl.setCreateTime(date);
            bookmarkFolderUrlService.save(bookmarkFolderUrl);
        } else {
            BookmarkLightningUrl bookmarkLightningUrl = new BookmarkLightningUrl(bookmarkUrl.getId(), userId, date);
            bookmarkLightningUrl.setAliasAddress(urlRo.getAddress());
            bookmarkLightningUrlService.save(bookmarkLightningUrl);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateBookmarkUrl(Long userId, EditFolderUrlRo urlRo) {
        // 先查询对应的URL数据，是否存在
        BookmarkUrl bookmarkUrl = this.getById(urlRo.getId());
        ServiceException.isTrue(Objects.isNull(bookmarkUrl), ExceptionConstants.NOT_FOUND_DATA);
        String domain;
        try {
            domain = DomainUtils.extractDomain(urlRo.getAddress());
        } catch (URISyntaxException e) {
            log.warn(e.getMessage());
            throw new ServiceException(ExceptionConstants.URL_VALID);
        }

        // 判断domain与原先的域名是否相同
        if (domain.equals(bookmarkUrl.getAddress())) {
            // 更新文件夹下的链接或者快速访问链接
            updateFolderUrlOrLightningUrl(userId, urlRo);
        } else {
            // 不同，则进行新建数据，并删除之前的关联关系
            if (Objects.nonNull(urlRo.getFolderId())) {
                LambdaQueryWrapper<BookmarkFolderUrl> queryWrapper = new LambdaQueryWrapper<>();
                queryWrapper.eq(BookmarkFolderUrl::getFolderId, urlRo.getFolderId())
                        .eq(BookmarkFolderUrl::getUrlId, urlRo.getId());
                bookmarkFolderUrlService.remove(queryWrapper);
            } else {
                LambdaQueryWrapper<BookmarkLightningUrl> queryWrapper = new LambdaQueryWrapper<>();
                queryWrapper.eq(BookmarkLightningUrl::getUserId, userId)
                        .eq(BookmarkLightningUrl::getUrlId, urlRo.getId());
                bookmarkLightningUrlService.remove(queryWrapper);
            }
            BookmarkUrlRo urlRo1 = new BookmarkUrlRo();
            BeanUtils.copyProperties(urlRo, urlRo1);
            this.addBookmarkUrl(userId, urlRo1);
        }

    }

    private void updateFolderUrlOrLightningUrl(Long userId, EditFolderUrlRo urlRo) {
        Date date = new Date();
        if (Objects.nonNull(urlRo.getFolderId())) {
            // 查询数据
            LambdaQueryWrapper<BookmarkFolderUrl> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(BookmarkFolderUrl::getFolderId, urlRo.getFolderId())
                    .eq(BookmarkFolderUrl::getUrlId, urlRo.getId());
            BookmarkFolderUrl bookmarkFolderUrl = bookmarkFolderUrlService.getOne(queryWrapper);
            ServiceException.isTrue(Objects.isNull(bookmarkFolderUrl), ExceptionConstants.NOT_FOUND_DATA);
            // 变更数据
            bookmarkFolderUrl.setUrlName(urlRo.getName());
            bookmarkFolderUrl.setAliasAddress(urlRo.getAddress());
            bookmarkFolderUrl.setDescription(urlRo.getDescription());
            bookmarkFolderUrl.setFavicon(urlRo.getFavicon());
            bookmarkFolderUrl.setUpdateBy(userId);
            bookmarkFolderUrl.setUpdateTime(date);
            bookmarkFolderUrlService.updateById(bookmarkFolderUrl);
        } else {
            // 添加快速访问链接
            LambdaQueryWrapper<BookmarkLightningUrl> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(BookmarkLightningUrl::getUserId, userId)
                    .eq(BookmarkLightningUrl::getUrlId, urlRo.getId());
            BookmarkLightningUrl lightningUrl = bookmarkLightningUrlService.getOne(queryWrapper);
            ServiceException.isTrue(Objects.isNull(lightningUrl), ExceptionConstants.NOT_FOUND_DATA);
            lightningUrl.setUrlName(urlRo.getName());
            lightningUrl.setAliasAddress(urlRo.getAddress());
            lightningUrl.setDescription(urlRo.getDescription());
            lightningUrl.setFavicon(urlRo.getFavicon());
            lightningUrl.setUpdateTime(date);
            bookmarkLightningUrlService.updateById(lightningUrl);
        }
    }

    @Override
    public void deleteBookmarkUrl(Long userId, Long urlId) {
        // 先查询对应的URL数据，是否存在
        BookmarkUrl bookmarkUrl = this.getById(urlId);
        ServiceException.isTrue(Objects.isNull(bookmarkUrl), ExceptionConstants.NOT_FOUND_DATA);
    }
}
