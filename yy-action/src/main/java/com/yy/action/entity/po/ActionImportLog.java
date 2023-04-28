package com.yy.action.entity.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

/**
 * @author sunruiguang
 * @date 2023-04-28
 */
@Getter
@Setter
@NoArgsConstructor
public class ActionImportLog {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String fileName;

    private Integer progress;

    private Long createBy;

    private Date createTime;

    private Date updateTime;
}
