package com.mango.api.wechat.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class WechatSessionVo implements Serializable {
    /**
     * 会话密钥
     */
    private String session_key;
    /**
     * 用户在开放平台的唯一标识符，若当前小程序已绑定到微信开放平台帐号下会返回
     */
    private String unionid;
    /**
     * 错误信息
     */
    private String errmsg;
    /**
     * 用户唯一标识
     */
    private String openid;
    /**
     * 错误码
     */
    private int errcode;
}
