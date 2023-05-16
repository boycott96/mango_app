package com.yy.action.config;

import com.yy.action.utils.SslUtils;
import io.minio.MinioClient;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Objects;

/**
 * @author sunruiguang
 * @date 2023-05-16
 */
@Configuration
@ConfigurationProperties(prefix = "minio")
@Getter
@Setter
public class MinioConfig {

    private String url;

    private String accessKey;

    private String secretKey;

    private String bucketName;

    @Bean
    public MinioClient getMinioClient() {
        return MinioClient.builder().endpoint(url).credentials(accessKey, secretKey)
                .httpClient(Objects.requireNonNull(SslUtils.getUnsafeOkHttpClient())).build();
    }
}
