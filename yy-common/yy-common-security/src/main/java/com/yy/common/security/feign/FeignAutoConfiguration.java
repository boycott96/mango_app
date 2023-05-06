package com.yy.common.security.feign;

import feign.RequestInterceptor;
import org.springframework.context.annotation.Bean;

/**
 * Feign 配置注册
 *
 * @author admin
 **/
public class FeignAutoConfiguration {
    @Bean
    public RequestInterceptor requestInterceptor() {
        return new FeignRequestInterceptor();
    }
}
