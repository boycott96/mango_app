package com.yy.bookmark.service.impl;

import com.alibaba.nacos.common.utils.ThreadFactoryBuilder;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.yy.api.RemoteLogService;
import com.yy.bookmark.entity.po.BookmarkFolder;
import com.yy.bookmark.entity.po.BookmarkFolderUser;
import com.yy.bookmark.entity.ro.FolderUrlRo;
import com.yy.bookmark.service.BookmarkFolderService;
import com.yy.bookmark.service.BookmarkFolderUserService;
import com.yy.bookmark.service.FolderService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.exception.ServiceException;
import com.yy.common.core.utils.ApiUtils;
import com.yy.common.redis.service.RedisService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @author sunruiguang
 * @date 2023-04-27
 */
@Service
public class FolderServiceImpl implements FolderService {

    private final BookmarkFolderService bookmarkFolderService;
    private final BookmarkFolderUserService bookmarkFolderUserService;
    private final RedisService redisService;
    private final RemoteLogService remoteLogService;

    // 多线程进行处理常驻3个线程，最大线程为10个，60s的存活时间，过期自动销毁线程
    private final ExecutorService es = new ThreadPoolExecutor(3, 10, 60L,
            TimeUnit.SECONDS, new LinkedBlockingDeque<>(), new ThreadFactoryBuilder().build());


    public FolderServiceImpl(BookmarkFolderService bookmarkFolderService,
                             BookmarkFolderUserService bookmarkFolderUserService,
                             RedisService redisService,
                             RemoteLogService remoteLogService) {
        this.bookmarkFolderService = bookmarkFolderService;
        this.bookmarkFolderUserService = bookmarkFolderUserService;
        this.redisService = redisService;
        this.remoteLogService = remoteLogService;
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
        bookmarkFolderService.save(bookmarkFolder);
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
        BookmarkFolder entity = bookmarkFolderService.getById(bookmarkFolder.getId());
        ServiceException.isTrue(Objects.isNull(entity), ExceptionConstants.NOT_FOUND_DATA);
        entity.setName(bookmarkFolder.getName());
        entity.setUpdateTime(new Date());
        bookmarkFolderService.updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteById(Long userId, Long folderId) {
        // 先查询对应的书签文件夹数据
        BookmarkFolder bookmarkFolder = bookmarkFolderService.getById(folderId);
        ServiceException.isTrue(!Objects.equals(bookmarkFolder.getCreateBy(), userId), ExceptionConstants.NOT_DATA_AUTH);

        // 如果创建人与当前操作人的id相同，则可以进行删除操作
        bookmarkFolderService.removeById(folderId);
        // 将关联的用户数据进行删除
        LambdaQueryWrapper<BookmarkFolderUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(BookmarkFolderUser::getFolderId, folderId);
        bookmarkFolderUserService.remove(queryWrapper);
    }

    @Override
    public void batchAdd(Long userId, List<FolderUrlRo> folderUrlRos) {
        // 进行导入的任务处理
        Long logId = ApiUtils.getData(() -> remoteLogService.addLog(String.valueOf(System.currentTimeMillis()), userId));
        // 对任务进行redis绑定key
        redisService.setCacheObject(logId.toString(), BigDecimal.ZERO);
        es.submit(() -> folderUrlRos.forEach(folder -> syncAddFolderAndUrl(folder, userId)));

    }

    @Transactional(rollbackFor = Exception.class)
    public void syncAddFolderAndUrl(FolderUrlRo folder, Long userId) {
        // 循环对文件夹进行插入
        BookmarkFolder bookmarkFolder = new BookmarkFolder();
        bookmarkFolder.setName(folder.getName());
        bookmarkFolder.setCreateBy(userId);
        Date date = new Date();
        bookmarkFolder.setCreateTime(date);
        bookmarkFolderService.save(bookmarkFolder);
        if (!CollectionUtils.isEmpty(folder.getUrlList())) {
            List<BookmarkFolderUser> collect = folder.getUrlList().stream().map(item -> {
                BookmarkFolderUser bookmarkFolderUser = new BookmarkFolderUser();
                bookmarkFolderUser.setFolderId(bookmarkFolder.getId());
                bookmarkFolderUser.setCreateTime(date);
                bookmarkFolderUser.setUserId(userId);
                bookmarkFolderUser.setType(false);
                return bookmarkFolderUser;
            }).toList();
            bookmarkFolderUserService.saveBatch(collect);
        }
    }
}
