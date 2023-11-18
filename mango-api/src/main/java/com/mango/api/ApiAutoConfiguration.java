package com.mango.api;

import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * @author yemingxing
 * @date 2022-03-11
 */
@Configuration
@ComponentScan(basePackages = {"com.mango.api"})
@EnableFeignClients(basePackages = {"com.mango.api"})
public @interface ApiAutoConfiguration {
}
