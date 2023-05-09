package com.yy.common.core.utils;

import java.net.URI;
import java.net.URISyntaxException;

/**
 * @author sunruiguang
 * @date 2023-05-09
 */
public class DomainUtils {

    /**
     * 抽取域名
     *
     * @param url 链接字符串
     * @return java.lang.String
     * @author sunruiguang
     * @since 2023/5/9
     */
    public static String extractDomain(String url) throws URISyntaxException {
        URI uri = new URI(url);
        return uri.getHost();
    }
}
