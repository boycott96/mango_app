package com.yy.bookmark.entity.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

/**
 * @author sunruiguang
 * @date 2023-05-06
 */
@Getter
@Setter
@NoArgsConstructor
public class BookmarkFolderUrl {

    /**
     * 关联ID
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 文件夹ID
     */
    private Long folderId;

    /**
     * 书签URLID
     */
    private Long urlId;

    /**
     * 创建人
     */
    private Long createBy;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新人
     */
    private Long updateBy;

    /**
     * 更新时间
     */
    private Date updateTime;

    public BookmarkFolderUrl(Long folderId, Long urlId, Long createBy, Date createTime) {
        this.folderId = folderId;
        this.urlId = urlId;
        this.createBy = createBy;
        this.createTime = createTime;
    }
}
