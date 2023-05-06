package com.yy.common.security.feign;

import com.yy.common.core.constant.SecurityConstants;
import com.yy.common.core.context.SecurityContextHolder;
import com.yy.common.core.utils.IpUtils;
import com.yy.common.core.utils.ServletUtils;
import com.yy.common.core.utils.StringUtils;
import feign.RequestInterceptor;
import feign.RequestTemplate;

/**
 * feign 请求拦截器
 *
 * @author admin
 */
public class FeignRequestInterceptor implements RequestInterceptor {
    @Override
    public void apply(RequestTemplate requestTemplate) {
        // 传递用户信息请求头，防止丢失
        String userId = SecurityContextHolder.get(SecurityConstants.DETAILS_USER_ID);
        if (StringUtils.isNotEmpty(userId)) {
            requestTemplate.header(SecurityConstants.DETAILS_USER_ID, userId);
        }
        String userName = SecurityContextHolder.get(SecurityConstants.DETAILS_USERNAME);
        if (StringUtils.isNotEmpty(userName)) {
            requestTemplate.header(SecurityConstants.DETAILS_USERNAME, userName);
        }
        String authentication = SecurityContextHolder.get(SecurityConstants.AUTHORIZATION_HEADER);
        if (StringUtils.isNotEmpty(authentication)) {
            requestTemplate.header(SecurityConstants.AUTHORIZATION_HEADER, authentication);
        }

        // 配置客户端IP
        requestTemplate.header("X-Forwarded-For", IpUtils.getIpAddr(ServletUtils.getRequest()));
    }
}
