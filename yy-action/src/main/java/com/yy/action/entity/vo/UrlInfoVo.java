package com.yy.action.entity.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * @author sunruiguang
 * @date 2023-05-16
 */
@NoArgsConstructor
@Getter
@Setter
public class UrlInfoVo {

    /**
     * 链接标题
     */
    private String title;

    /**
     * 图标
     */
    private String icon;

    /**
     * 缩略图
     */
    private String thumbnail;
}
