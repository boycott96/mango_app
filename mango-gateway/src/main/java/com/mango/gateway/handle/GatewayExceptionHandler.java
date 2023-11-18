package com.mango.gateway.handle;

import com.mango.common.core.utils.ServletUtils;
import org.jetbrains.annotations.NotNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.reactive.error.ErrorWebExceptionHandler;
import org.springframework.cloud.gateway.support.NotFoundException;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

/**
 * 网关统一异常处理
 *
 * @author yeyang
 */
@Order(-1)
@Configuration
public class GatewayExceptionHandler implements ErrorWebExceptionHandler {
    private static final Logger log = LoggerFactory.getLogger(GatewayExceptionHandler.class);

    @Override
    public @NotNull Mono<Void> handle(ServerWebExchange exchange, @NotNull Throwable ex) {
        ServerHttpResponse response = exchange.getResponse();

        if (exchange.getResponse().isCommitted()) {
            return Mono.error(ex);
        }

        String message;

        if (ex instanceof NotFoundException) {
            message = "服务未找到";
            ex.printStackTrace();
        } else if (ex instanceof ResponseStatusException responseStatusException) {
            message = responseStatusException.getMessage();
        } else {
            message = "服务器错误，请稍后重试";
        }
        log.error("[网关异常处理]请求路径:{},异常信息:{}", exchange.getRequest().getPath(), ex.getMessage());

        return ServletUtils.webFluxResponseWriter(response, message);
    }
}