package com.mango.api.wechat.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author sunruiguang
 * @date 2023-03-09
 */
@Getter
@Setter
@NoArgsConstructor
@ToString
public class WechatTokenVo {
    /**
     * 网页授权接口调用凭证
     */
    private String access_token;

    /**
     * access_token接口调用凭证超时时间
     */
    private int expires_in;

    /**
     * 用户刷新access_token
     */
    private String refresh_token;

    /**
     * 用户唯一标识，请注意
     */
    private String openid;

    /**
     * 用户授权的作用域
     */
    private String scope;

    /**
     * 是否为快照页模式虚拟账号
     */
    private String is_snapshotuser;

    /**
     * 用户统一标识
     */
    private String unionid;

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
