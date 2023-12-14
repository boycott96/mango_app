package com.mango.word.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 考题
* @TableName word_exam
*/
@Getter
@Setter
@NoArgsConstructor
public class WordExam implements Serializable {

    /**
    * 考题ID
    */
    private Long id;
    /**
    * 单词ID
    */
    private Long wordId;
    /**
    * 问题
    */
    private String question;
    /**
    * 考题类型[1: 选择题]
    */
    private Integer examType;
    /**
    * 问题答案解析
    */
    private String answerExplain;
    /**
    * 答案
    */
    private Integer answerIndex;
}
