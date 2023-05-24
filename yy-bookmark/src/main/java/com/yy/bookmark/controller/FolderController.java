package com.yy.bookmark.controller;

import com.yy.api.RemoteAuthUserService;
import com.yy.api.model.LoginUser;
import com.yy.bookmark.entity.po.BookmarkFolder;
import com.yy.bookmark.entity.ro.FolderRo;
import com.yy.bookmark.entity.ro.FolderUrlRo;
import com.yy.bookmark.entity.vo.FolderListVo;
import com.yy.bookmark.service.BookmarkFolderService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.domain.R;
import com.yy.common.security.utils.SecurityUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
import java.util.List;

/**
 * 文件夹接口
 *
 * @author sunruiguang
 * @date 2023-04-27
 */
@RequestMapping("/folder")
@RestController
public class FolderController {

    private final BookmarkFolderService bookmarkFolderService;
    private final RemoteAuthUserService remoteAuthUserService;

    public FolderController(BookmarkFolderService bookmarkFolderService,
                            RemoteAuthUserService remoteAuthUserService) {
        this.bookmarkFolderService = bookmarkFolderService;
        this.remoteAuthUserService = remoteAuthUserService;
    }

    /**
     * 创建文件夹
     *
     * @param name 添加名称
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/4/27
     */
    @PostMapping("/add")
    @Validated
    public R<?> addFolder(@RequestParam("name")
                          @Size(max = 12, message = ExceptionConstants.PARAM_LENGTH_INVALID)
                          @NotBlank(message = ExceptionConstants.PARAM_INVALID) String name) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        bookmarkFolderService.createFolder(loginUser.getId(), name);
        return R.ok();
    }

    /**
     * 修改文件夹数据
     *
     * @param folderRo 修改文件夹的接口
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/4/27
     */
    @PutMapping("/update")
    public R<?> updateFolder(@Validated @RequestBody FolderRo folderRo) {
        BookmarkFolder bookmarkFolder = new BookmarkFolder(folderRo.getId(), folderRo.getName());
        bookmarkFolderService.updateFolder(bookmarkFolder);
        return R.ok();
    }

    /**
     * 删除文件夹数据
     *
     * @param folderId 文件夹ID
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/4/28
     */
    @DeleteMapping("/delete/{folderId}")
    public R<?> deleteById(@PathVariable("folderId") Long folderId) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        bookmarkFolderService.deleteById(loginUser.getId(), folderId);
        return R.ok();
    }

    /**
     * 批量导入文件夹和书签的数据
     *
     * @param folderUrlRos 文件夹和书签的数据
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/4/28
     */
    @PostMapping("/batch/add")
    public R<?> batchAdd(@Validated @NotEmpty(message = ExceptionConstants.NOT_DATA_EMPTY) @RequestBody List<FolderUrlRo> folderUrlRos) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        bookmarkFolderService.batchAdd(loginUser.getId(), folderUrlRos);
        return R.ok();
    }

    /**
     * 查询文件夹信息
     *
     * @return com.yy.common.core.domain.R<java.util.List < com.yy.bookmark.entity.vo.FolderListVo>>
     * @author sunruiguang
     * @since 2023/5/23
     */
    @GetMapping("/list")
    public R<List<FolderListVo>> listFolder() {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        return R.ok(bookmarkFolderService.queryByUserId(loginUser.getId()));
    }
}
