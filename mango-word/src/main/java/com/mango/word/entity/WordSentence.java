package com.mango.word.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 句子
* @TableName word_sentence
*/
@Getter
@Setter
@NoArgsConstructor
public class WordSentence implements Serializable {

    /**
    * 句子ID
    */
    private Long id;
    /**
    * 单词ID
    */
    private Long wordId;
    /**
    * 句子内容
    */
    private String enContent;
    /**
    * 中文翻译内容
    */
    private String zhContent;
}
