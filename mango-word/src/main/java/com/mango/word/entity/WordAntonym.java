package com.mango.word.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 反义词
 * @TableName word_antonym
 */
@Getter
@Setter
@NoArgsConstructor
public class WordAntonym implements Serializable {
    /**
     * 反义ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 单词ID
     */
    private Long wordId;

    /**
     * 反义词
     */
    private String enContent;

    public WordAntonym(Long wordId, String enContent) {
        this.wordId = wordId;
        this.enContent = enContent;
    }
}