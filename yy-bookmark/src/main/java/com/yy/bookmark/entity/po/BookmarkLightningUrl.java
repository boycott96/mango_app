package com.yy.bookmark.entity.po;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

/**
 * @author sunruiguang
 * @date 2023-05-09
 */
@Getter
@Setter
@NoArgsConstructor
public class BookmarkLightningUrl {

    /**
     * 关联ID
     */
    private Long id;

    /**
     * URL ID
     */
    private Long urlId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 别名地址
     */
    private String aliasAddress;

    /**
     * 图标
     */
    private String favicon;

    /**
     * 描述
     */
    private String description;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 链接名称
     */
    private String urlName;

    public BookmarkLightningUrl(Long urlId, Long userId, Date createTime) {
        this.urlId = urlId;
        this.userId = userId;
        this.createTime = createTime;
    }
}
