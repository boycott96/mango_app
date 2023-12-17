package com.mango.api.wechat.configuration;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/**
 * @author yemingxing
 * @date 2022-08-09
 */
@Configuration
@ConfigurationProperties(prefix = "api.wechat.miniprogram")
@Getter
@Setter
public class WechatMiniProgramProperties {
    /**
     * 小程序 appId
     */
    private String appId;
    /**
     * 小程序 appSecret
     */
    private String appSecret;
}
