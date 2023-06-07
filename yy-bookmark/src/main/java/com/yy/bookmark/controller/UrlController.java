package com.yy.bookmark.controller;

import com.yy.api.model.LoginUser;
import com.yy.bookmark.entity.ro.BookmarkUrlRo;
import com.yy.bookmark.entity.ro.CollectUrlRo;
import com.yy.bookmark.entity.ro.EditFolderUrlRo;
import com.yy.bookmark.service.BookmarkUrlService;
import com.yy.common.core.domain.R;
import com.yy.common.security.utils.SecurityUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * @author sunruiguang
 * @date 2023-04-28
 */
@RestController
@RequestMapping("/url")
public class UrlController {

    private final BookmarkUrlService bookmarkUrlService;

    public UrlController(BookmarkUrlService bookmarkUrlService) {
        this.bookmarkUrlService = bookmarkUrlService;
    }

    /**
     * 添加书签
     *
     * @param urlRo 书签的参数
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/5/9
     */
    @PostMapping("/add")
    public R<?> addBookmarkUrl(@Validated @RequestBody BookmarkUrlRo urlRo) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        bookmarkUrlService.addBookmarkUrl(loginUser.getId(), urlRo);
        return R.ok();
    }

    /**
     * 修改书签
     *
     * @param urlRo 书签的参数
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/5/9
     */
    @PutMapping("/update")
    public R<?> updateBookmarkUrl(@Validated @RequestBody EditFolderUrlRo urlRo) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        bookmarkUrlService.updateBookmarkUrl(loginUser.getId(), urlRo);
        return R.ok();
    }

    /**
     * 关注书签链接
     *
     * @param urlRo 收藏链接到文件夹/快速访问
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/5/9
     */
    @PostMapping("/collect")
    public R<?> collectBookmarkUrl(@Validated @RequestBody CollectUrlRo urlRo) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        bookmarkUrlService.collect(loginUser.getId(), urlRo);
        return R.ok();
    }
}
