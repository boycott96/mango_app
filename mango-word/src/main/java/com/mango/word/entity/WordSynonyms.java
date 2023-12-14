package com.mango.word.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 单词详情
* @TableName word_synonyms
*/
@Getter
@Setter
@NoArgsConstructor
public class WordSynonyms implements Serializable {

    /**
    * 单词详情ID
    */
    private Long id;
    /**
    * 单词ID
    */
    private Long wordId;
    /**
    * 词类型
    */
    private String wordType;
    /**
    * 单词中文含义
    */
    private String zhContent;
}
