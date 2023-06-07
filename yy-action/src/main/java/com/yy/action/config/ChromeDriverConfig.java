package com.yy.action.config;

import io.github.bonigarcia.wdm.WebDriverManager;
import lombok.Getter;
import lombok.Setter;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author sunruiguang
 * @date 2023-05-16
 */
@Configuration
@ConfigurationProperties(prefix = "config")
@Getter
@Setter
public class ChromeDriverConfig {

    private String driver;

    @Bean
    public WebDriver chromeDriver() {
        WebDriverManager.chromedriver().setup();
        return new ChromeDriver();
    }
}
