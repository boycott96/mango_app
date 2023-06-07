package com.yy.bookmark.entity.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

/**
 * @author sunruiguang
 * @date 2023-04-27
 */
@Getter
@Setter
@NoArgsConstructor
public class BookmarkFolderUser {

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
     * 用户ID
     */
    private Long userId;

    /**
     * 类型 true: 关注者, false: 创建者
     */
    private boolean type;

    /**
     * 排序
     */
    private Long folderSort;

    /**
     * 关联时间
     */
    private Date createTime;
}
