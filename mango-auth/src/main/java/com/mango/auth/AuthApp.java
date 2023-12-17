package com.mango.auth;

import com.mango.api.wechat.configuration.WechatMiniProgramProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

/**
 * @author sunruiguang
 * @date 2022-11-14
 */
@SpringBootApplication
//@EnableConfigurationProperties(WechatMiniProgramProperties.class)
public class AuthApp {
    public static void main(String[] args) {
        SpringApplication.run(AuthApp.class);
    }
}
