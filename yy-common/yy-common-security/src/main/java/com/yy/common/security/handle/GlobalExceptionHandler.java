package com.yy.common.security.handle;

import com.alibaba.fastjson2.JSON;
import com.yy.common.core.exception.InnerAuthException;
import com.yy.common.core.exception.ServiceException;
import com.yy.common.core.exception.auth.NotPermissionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/*
 * 全局异常处理器
 *
 * @author yeyang
 */
@RestControllerAdvice
public class GlobalExceptionHandler {
    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    /**
     * 权限码异常
     */
    @ExceptionHandler(NotPermissionException.class)
    public void handleNotPermissionException(NotPermissionException e, HttpServletRequest request, HttpServletResponse response) {
        String requestURI = request.getRequestURI();
        log.error("请求地址'{}',权限码校验失败'{}'", requestURI, e.getMessage());
        this.setResponse(response, HttpStatus.FORBIDDEN, e.getMessage());
    }

    /**
     * 请求方式不支持
     */
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public void handleHttpRequestMethodNotSupported(HttpRequestMethodNotSupportedException e,
                                                    HttpServletRequest request, HttpServletResponse response) {
        String requestURI = request.getRequestURI();
        log.error("请求地址'{}',不支持'{}'请求", requestURI, e.getMethod());
        this.setResponse(response, HttpStatus.BAD_REQUEST, e.getMessage());
    }

    /**
     * 业务异常
     */
    @ExceptionHandler(ServiceException.class)
    public void handleServiceException(ServiceException e, HttpServletResponse response) {
        log.error(e.getMessage(), e);
        this.setResponse(response, HttpStatus.PRECONDITION_FAILED, e.getMessage());
    }

    /**
     * 拦截未知的运行时异常
     */
    @ExceptionHandler(RuntimeException.class)
    public void handleRuntimeException(RuntimeException e, HttpServletRequest request, HttpServletResponse response) {
        String requestURI = request.getRequestURI();
        log.error("请求地址'{}',发生未知异常.", requestURI, e);
        this.setResponse(response, HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage());
    }

    /**
     * 系统异常
     */
    @ExceptionHandler(Exception.class)
    public void handleException(Exception e, HttpServletRequest request, HttpServletResponse response) {
        String requestURI = request.getRequestURI();
        log.error("请求地址'{}',发生系统异常.", requestURI, e);
        this.setResponse(response, HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage());
    }

    /**
     * 内部认证异常
     */
    @ExceptionHandler(InnerAuthException.class)
    public void handleInnerAuthException(InnerAuthException e, HttpServletResponse response) {
        this.setResponse(response, HttpStatus.PRECONDITION_FAILED, e.getMessage());
    }

    /**
     * 设置返回流数据
     *
     * @param response 服务器返回流
     * @param status   http状态枚举
     * @param message  返回消息
     * @author sunruiguang
     * @since 2022/12/8
     */
    private void setResponse(HttpServletResponse response, HttpStatus status, String message) {
        response.setStatus(status.value());
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        Map<String, String> map = new HashMap<>();
        map.put("message", message);
        try {
            response.getWriter().print(JSON.toJSONString(map));
        } catch (Exception e) {
            response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
        }
    }
}
