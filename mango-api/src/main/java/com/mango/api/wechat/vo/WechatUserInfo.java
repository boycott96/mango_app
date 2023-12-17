package com.mango.api.wechat.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

/**
 * @author sunruiguang
 * @date 2023-03-10
 */
@Getter
@Setter
@NoArgsConstructor
public class WechatUserInfo {
    /**
     * 唯一标识
     */
    private String openId;

    /**
     * 姓名
     */
    private String nickName;

    /**
     * 性别
     */
    private int sex;

    /**
     * 省份
     */
    private String province;

    /**
     * 城市
     */
    private String city;

    /**
     * 地区
     */
    private String country;

    /**
     * 头像
     */
    private String headimgurl;

    private List<String> privilege;

    private String unionId;

    /**
     * 错误编码
     * 40029  Code 无效
     */
    private int errcode;

    /**
     * 错误信息
     */
    private String errmsg;
}
