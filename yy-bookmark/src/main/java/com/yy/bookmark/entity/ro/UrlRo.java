package com.yy.bookmark.entity.ro;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * @author sunruiguang
 * @date 2023-04-28
 */
@Getter
@Setter
@NoArgsConstructor
public class UrlRo {

    /**
     * 书签名称
     */
    private String name;

    /**
     * 书签地址
     */
    private String address;

    /**
     * 书签描述
     */
    private String description;

    /**
     * 书签icon
     */
    private String favicon;
}
