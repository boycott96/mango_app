package com.mango.word.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

/**
* 真题例句
* @TableName word_real_exam
*/
@Getter
@Setter
@NoArgsConstructor
public class WordRealExam implements Serializable {

    /**
    * 真题ID
    */
    private Long id;
    /**
    * 单词ID
    */
    private Long wordId;
    /**
    * 例句
    */
    private String enContent;
    /**
    * CET4
    */
    private String sourceLevel;
    /**
    * 年份
    */
    private String sourceYear;
    /**
    * 题目类型
    */
    private String sourceType;
}
