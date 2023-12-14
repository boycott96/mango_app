package com.mango.word.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 单词
* @TableName word
*/
@Getter
@Setter
@NoArgsConstructor
public class Word implements Serializable {

    /**
    * 单词ID
    */
    private Long id;
    /**
    * 书籍ID
    */
    private Long bookId;
    /**
    * 单词内容
    */
    private String wordHead;
    /**
    * 单词音标
    */
    private String usPhone;
    /**
    * 单词音标
    */
    private String ukPhone;
    /**
    * 单词发音
    */
    private String usSpeech;
    /**
    * 单词发音
    */
    private String ukSpeech;
    /**
    * 单词音标
    */
    private String phone;
    /**
    * 单词发音
    */
    private String speech;
    /**
    * 记忆方式
    */
    private String remMethod;
}
