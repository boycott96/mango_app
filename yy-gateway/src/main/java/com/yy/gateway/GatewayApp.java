package com.yy.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 网关启动类
 *
 * @author sun
 */
@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)
public class GatewayApp {
    public static void main(String[] args) {
        SpringApplication.run(GatewayApp.class);
    }
}
