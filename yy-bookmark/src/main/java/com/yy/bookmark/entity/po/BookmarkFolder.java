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
public class BookmarkFolder {

    /**
     * 文件夹ID
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 文件夹名称
     */
    private String name;

    /**
     * 点赞数
     */
    private Long likeNum;

    /**
     * 收藏数
     */
    private Long starNum;

    /**
     * 查看数
     */
    private Long viewNum;

    /**
     * 评论数
     */
    private Long commentNum;

    /**
     * 创建人
     */
    private Long createBy;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    public BookmarkFolder(Long id, String name) {
        this.id = id;
        this.name = name;
    }
}
