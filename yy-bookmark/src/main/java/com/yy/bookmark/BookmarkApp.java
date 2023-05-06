package com.yy.bookmark;

import com.yy.common.security.feign.FeignAutoConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Import;

/**
 * @author sunruiguang
 * @date 2023-04-27
 */
@SpringBootApplication
@EnableFeignClients
@Import({FeignAutoConfiguration.class})
public class BookmarkApp {
    public static void main(String[] args) {
        SpringApplication.run(BookmarkApp.class);
    }
}
