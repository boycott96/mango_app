package com.mango.word.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 近义词
* @TableName word_synonyms_word
*/
@Getter
@Setter
@NoArgsConstructor
public class WordSynonymsWord implements Serializable {

    /**
    * ID
    */
    private Long id;
    /**
    * 单词详情ID
    */
    private Long wordInfoId;
    /**
    * 近义词
    */
    private String enContent;
}
