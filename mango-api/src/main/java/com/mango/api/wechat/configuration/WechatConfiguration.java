package com.mango.api.wechat.configuration;

import feign.codec.Decoder;
import org.springframework.context.annotation.Bean;

public class WechatConfiguration {

    @Bean
    public Decoder wechatDecoder() {
        return new WechatDecoder();
    }
}
