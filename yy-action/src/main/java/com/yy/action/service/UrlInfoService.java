package com.yy.action.service;

import com.yy.action.entity.vo.UrlInfoVo;

public interface UrlInfoService {

    /**
     * 获取网址信息
     *
     * @param url 网址url
     * @return com.yy.action.entity.vo.UrlInfoVo
     * @author sunruiguang
     * @since 2023/5/16
     */
    UrlInfoVo getUrlInfo(String url);
}
