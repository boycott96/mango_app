package com.yy.bookmark.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.api.RemoteAuthUserService;
import com.yy.api.RemoteLogService;
import com.yy.api.entity.AuthUser;
import com.yy.bookmark.entity.po.BookmarkFolder;
import com.yy.bookmark.entity.po.BookmarkFolderUser;
import com.yy.bookmark.entity.ro.FolderUrlRo;
import com.yy.bookmark.entity.vo.FolderListVo;
import com.yy.bookmark.mapper.BookmarkFolderMapper;
import com.yy.bookmark.service.BookmarkFolderService;
import com.yy.bookmark.service.BookmarkFolderUserService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.exception.ServiceException;
import com.yy.common.core.utils.ApiUtils;
import com.yy.common.redis.service.RedisService;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author sunruiguang
 * @date 2023-05-06
 */
@Service
public class BookmarkFolderServiceImpl extends ServiceImpl<BookmarkFolderMapper, BookmarkFolder> implements BookmarkFolderService {


    private final BookmarkFolderUserService bookmarkFolderUserService;
    private final RedisService redisService;
    private final RemoteLogService remoteLogService;
    private final RemoteAuthUserService remoteAuthUserService;

    public BookmarkFolderServiceImpl(BookmarkFolderUserService bookmarkFolderUserService,
                                     RedisService redisService,
                                     RemoteLogService remoteLogService,
                                     RemoteAuthUserService remoteAuthUserService) {
        this.bookmarkFolderUserService = bookmarkFolderUserService;
        this.redisService = redisService;
        this.remoteLogService = remoteLogService;
        this.remoteAuthUserService = remoteAuthUserService;
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
        this.save(bookmarkFolder);
        // 插入关联表
        BookmarkFolderUser bookmarkFolderUser = new BookmarkFolderUser();
        bookmarkFolderUser.setFolderId(bookmarkFolder.getId());
        bookmarkFolderUser.setUserId(id);
        bookmarkFolderUser.setType(false);
        bookmarkFolderUser.setFolderSort(bookmarkFolderUserService.getMaxSortByUserId(id) + 1);
        bookmarkFolderUser.setCreateTime(date);
        bookmarkFolderUserService.save(bookmarkFolderUser);
    }

    @Override
    public void updateFolder(BookmarkFolder bookmarkFolder) {
        // 先查询对应的书签文件夹数据
        BookmarkFolder entity = this.getById(bookmarkFolder.getId());
        ServiceException.isTrue(Objects.isNull(entity), ExceptionConstants.NOT_FOUND_DATA);
        entity.setName(bookmarkFolder.getName());
        entity.setUpdateTime(new Date());
        this.updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteById(Long userId, Long folderId) {
        // 先查询对应的书签文件夹数据
        BookmarkFolder bookmarkFolder = this.getById(folderId);
        ServiceException.isTrue(!Objects.equals(bookmarkFolder.getCreateBy(), userId), ExceptionConstants.NOT_DATA_AUTH);

        // 如果创建人与当前操作人的id相同，则可以进行删除操作
        this.removeById(folderId);
        // 将关联的用户数据进行删除
        LambdaQueryWrapper<BookmarkFolderUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(BookmarkFolderUser::getFolderId, folderId);
        bookmarkFolderUserService.remove(queryWrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void batchAdd(Long userId, List<FolderUrlRo> folderUrlRos) {
        // 进行导入的任务处理
        Long logId = ApiUtils.getData(() -> remoteLogService.addLog(String.valueOf(System.currentTimeMillis()), userId));
        // 对任务进行redis绑定key
        redisService.setCacheObject(logId.toString(), BigDecimal.ZERO);
        folderUrlRos.forEach(folder -> syncAddFolderAndUrl(folder, userId));
    }

    public void syncAddFolderAndUrl(FolderUrlRo folder, Long userId) {
        // 循环对文件夹进行插入
        BookmarkFolder bookmarkFolder = new BookmarkFolder();
        bookmarkFolder.setName(folder.getName());
        bookmarkFolder.setCreateBy(userId);
        Date date = new Date();
        bookmarkFolder.setCreateTime(date);
        this.save(bookmarkFolder);
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

    @Override
    public List<FolderListVo> queryByUserId(Long userId) {
        // 查询关联表数据
        LambdaQueryWrapper<BookmarkFolderUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(BookmarkFolderUser::getUserId, userId);
        List<BookmarkFolderUser> bookmarkFolderUserList = bookmarkFolderUserService.list(queryWrapper);
        Map<Long, Long> folderUserMap = bookmarkFolderUserList.stream().collect(Collectors.toMap(BookmarkFolderUser::getFolderId, BookmarkFolderUser::getFolderSort));
        List<Long> folderIds = bookmarkFolderUserList.stream().map(BookmarkFolderUser::getFolderId).distinct().toList();
        List<BookmarkFolder> bookmarkFolderList = this.listByIds(folderIds);
        // 查询创建人数据
        List<Long> createByIds = bookmarkFolderList.stream().map(BookmarkFolder::getCreateBy).distinct().toList();
        List<AuthUser> listData = ApiUtils.getListData(() -> remoteAuthUserService.getUserByIds(createByIds));
        Map<Long, String> createByMap = listData.stream().collect(Collectors.toMap(AuthUser::getId, AuthUser::getStageName));

        return bookmarkFolderList.stream().map(item -> {
            FolderListVo vo = new FolderListVo();
            BeanUtils.copyProperties(item, vo);
            vo.setFolderSort(folderUserMap.get(item.getId()));
            vo.setCreateByName(createByMap.get(item.getCreateBy()));
            return vo;
        }).sorted(Comparator.comparing(FolderListVo::getFolderSort)).toList();
    }
}
