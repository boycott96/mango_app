package com.yy.bookmark.entity.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.yy.common.core.utils.DateUtils;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

/**
 * @author sunruiguang
 * @date 2023-05-23
 */
@Getter
@Setter
@NoArgsConstructor
public class FolderListVo {

    /**
     * 文件夹ID
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    private Long id;

    /**
     * 文件夹名称
     */
    private String name;

    /**
     * 收藏数
     */
    private Long starNum;

    /**
     * 查阅数
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
     * 创建人名称
     */
    @JsonFormat(pattern = DateUtils.CHINESE_YYYY_MM_DD)
    private String createByName;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = DateUtils.CHINESE_YYYY_MM_DD)
    private Date createTime;

    /**
     * 排序值
     */
    private Long folderSort;
}
