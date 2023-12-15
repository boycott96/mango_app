package com.mango.word.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 同根词
 *
 * @TableName word_same_root
 */
@Getter
@Setter
@NoArgsConstructor
public class WordSameRoot implements Serializable {

    /**
     * ID
     */
    private Long id;
    /**
     * 单词ID
     */
    private Long wordId;
    /**
     * 单词类型
     */
    private String expandWordType;
    /**
     * 单词扩展
     */
    private String expandWord;

    private String zhContent;

    public WordSameRoot(Long wordId, String expandWordType, String expandWord, String zhContent) {
        this.wordId = wordId;
        this.expandWordType = expandWordType;
        this.expandWord = expandWord;
        this.zhContent = zhContent;
    }
}
