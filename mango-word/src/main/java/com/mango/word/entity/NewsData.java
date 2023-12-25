package com.mango.word.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 新闻数据记录
 * @TableName news_data
 */
@Data
public class NewsData implements Serializable {
    /**
     * 主键ID
     */
    private Long id;

    /**
     * 来源组织名称
     */
    private String sourceName;

    /**
     * 作者名称
     */
    private String author;

    /**
     * 文章标题
     */
    private String title;

    /**
     * 文章描述
     */
    private String description;

    /**
     * 文章链接
     */
    private String url;

    /**
     * 文章图片
     */
    private String urlToImage;

    /**
     * 文章替代图片
     */
    private String titlePage;

    /**
     * 文章发表时间
     */
    private String publishedAt;

    private Date publishedTime;

    /**
     * 文章内容
     */
    private String content;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 文章时间日
     */
    private String dateTimeStr;

}