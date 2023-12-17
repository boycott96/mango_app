package com.mango.api.wechat.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * @author sunruiguang
 * @date 2023-03-13
 */
@Getter
@Setter
@NoArgsConstructor
public class JsApiTicketVo {

    /**
     * 错误编码
     */
    private int errcode;

    /**
     * 错误信息
     */
    private String errmsg;

    /**
     * 票据
     */
    private String ticket;

    /**
     * 过期时间
     */
    private int expires_in;
}
