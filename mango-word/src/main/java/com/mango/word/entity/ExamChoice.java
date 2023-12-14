package com.mango.word.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 考题选择项
 *
 * @TableName exam_choice
 */
@Getter
@Setter
@NoArgsConstructor
public class ExamChoice implements Serializable {

    /**
     * 选项ID
     */
    private Long id;
    /**
     * 选项KEY
     */
    private Integer choiceIndex;
    /**
     * 选项单词
     */
    private String choice;
}
