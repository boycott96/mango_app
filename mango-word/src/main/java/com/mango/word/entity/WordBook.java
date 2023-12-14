package com.mango.word.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 单词书籍
* @TableName word_book
*/
@Getter
@Setter
@NoArgsConstructor
public class WordBook implements Serializable {

    /**
    * 书籍ID
    */
    private Long id;
    /**
    * 书籍名称
    */
    private String bookName;
    /**
    * 书籍描述
    */
    private String description;
    /**
    * 单词数量
    */
    private Integer workNumber;
    /**
    * 封面图片
    */
    private String titlePage;
    /**
    * 书籍原始地址
    */
    private String originUrl;
}
