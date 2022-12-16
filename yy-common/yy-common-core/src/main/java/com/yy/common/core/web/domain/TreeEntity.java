package com.yy.common.core.web.domain;

import lombok.Getter;
import lombok.Setter;

import java.io.Serial;
import java.util.ArrayList;
import java.util.List;

/**
 * Tree基类
 *
 * @author sunruiguang
 */
@Getter
@Setter
public class TreeEntity extends BaseEntity {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 父菜单名称
     */
    private String parentName;

    /**
     * 父菜单ID
     */
    private Long parentId;

    /**
     * 显示顺序
     */
    private Integer orderNum;

    /**
     * 祖级列表
     */
    private String ancestors;

    /**
     * 子部门
     */
    private List<?> children = new ArrayList<>();
}
