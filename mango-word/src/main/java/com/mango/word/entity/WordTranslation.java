package com.mango.word.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 单词翻译信息
 *
 * @TableName word_translation
 */
@Getter
@Setter
@NoArgsConstructor
public class WordTranslation implements Serializable {

    /**
     * 中文翻译ID
     */
    private Long id;
    /**
     * 单词ID
     */
    private Long wordId;
    /**
     * 中文翻译
     */
    private String zhTranslation;
    /**
     * 单词类型
     */
    private String wordType;
    /**
     * 英文翻译
     */
    private String enTranslation;
}
