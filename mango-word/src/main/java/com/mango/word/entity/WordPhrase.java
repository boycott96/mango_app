package com.mango.word.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
* 常用短语
* @TableName word_phrase
*/
@Getter
@Setter
@NoArgsConstructor
public class WordPhrase implements Serializable {

    /**
    * 短语ID
    */
    @TableId(type = IdType.AUTO)
    private Long id;
    /**
    * 单词ID
    */
    private Long wordId;
    /**
    * 短语
    */
    private String commonPhrase;
    /**
    * 短语翻译
    */
    private String zhContent;

    public WordPhrase(Long wordId, String commonPhrase, String zhContent) {
        this.wordId = wordId;
        this.commonPhrase = commonPhrase;
        this.zhContent = zhContent;
    }
}
