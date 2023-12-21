package com.mango.api.bbc.configuration;

import com.mango.api.wechat.configuration.WechatDecoder;
import feign.codec.Decoder;
import org.springframework.context.annotation.Bean;

public class NewsConfiguration {
    @Bean
    public Decoder newsDecoder() {
        return new NewsDecoder();
    }

}
