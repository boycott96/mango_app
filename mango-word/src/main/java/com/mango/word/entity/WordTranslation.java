package com.mango.word.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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
    @TableId(type = IdType.AUTO)
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

    public WordTranslation(Long wordId, String zhTranslation, String wordType, String enTranslation) {
        this.wordId = wordId;
        this.zhTranslation = zhTranslation;
        this.wordType = wordType;
        this.enTranslation = enTranslation;
    }
}
