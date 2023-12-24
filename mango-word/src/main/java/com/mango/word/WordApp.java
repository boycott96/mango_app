package com.mango.word;

import com.mango.common.security.feign.FeignAutoConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

/**
 * @author sunruiguang
 * @date 2023-04-27
 */
@SpringBootApplication
@EnableFeignClients
@EnableScheduling
@Import({FeignAutoConfiguration.class})
public class WordApp {
    public static void main(String[] args) {
        SpringApplication.run(WordApp.class);
    }
}
