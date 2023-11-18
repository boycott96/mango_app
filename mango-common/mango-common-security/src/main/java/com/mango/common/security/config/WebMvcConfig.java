package com.mango.common.security.config;

import com.mango.common.security.interceptor.HeaderInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author sunruiguang
 * @date 2022-11-29
 */
public class WebMvcConfig implements WebMvcConfigurer {

    /**
     * 不需要拦截地址
     */
    public static final String[] excludeUrls = {"/login", "/logout", "/refresh", "/check/unique"};

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(getHeaderInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns(excludeUrls)
                .order(-10);
    }

    /**
     * 自定义请求头拦截器
     */
    public HeaderInterceptor getHeaderInterceptor() {
        return new HeaderInterceptor();
    }
}
