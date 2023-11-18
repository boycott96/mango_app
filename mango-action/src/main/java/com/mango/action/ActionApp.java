package com.mango.action;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * @author sunruiguang
 * @date 2023-04-28
 */
@SpringBootApplication
@EnableFeignClients
public class ActionApp {

    public static void main(String[] args) {
        SpringApplication.run(ActionApp.class);
    }
}
