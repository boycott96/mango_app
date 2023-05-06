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
public class BookmarkUrl {

    /**
     * ID
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 书签名称
     */
    private String name;

    /**
     * 书签地址
     */
    private String address;

    /**
     * 书签描述
     */
    private String description;

    /**
     * 书签图标
     */
    private String favicon;

    /**
     * 查看数
     */
    private Long viewNum;

    /**
     * 点赞数
     */
    private Long likeNum;

    /**
     * 添加快速访问数
     */
    private Long lightningNum;

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
}
