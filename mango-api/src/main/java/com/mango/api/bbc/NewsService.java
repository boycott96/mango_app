package com.mango.api.bbc;

import cn.hutool.core.text.UnicodeUtil;
import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import cn.hutool.http.HttpUtil;
import com.alibaba.fastjson2.JSON;
import com.mango.api.bbc.dto.NewsDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
public class NewsService {

    public final static String url = "https://newsapi.org/v2/";
    public final static String top_head_path = "/top-headlines";
    private final static String API_KEY = "1c712421229f4be991f0e4e86f8738c9";
    private static final Map<String, Object> TOP_HEAD_PARAM = new HashMap<>();

    static {
        TOP_HEAD_PARAM.put("country", "us");
        TOP_HEAD_PARAM.put("apiKey", API_KEY);
    }

    public NewsDto getTopHeadlinesByCountry() {
        // 查询数据
        try {
            HttpRequest request = HttpUtil.createPost(url + top_head_path);
//            request.header("content-type:", "application/json");
            request.form(TOP_HEAD_PARAM);
            HttpResponse execute = request.execute();
            if (!execute.isOk()) {
                log.error("请求token失败,body={},execute={}", execute.body(), execute);
                throw new RuntimeException(execute.body());
            }
            String res = UnicodeUtil.toString(execute.body());
            // todo 数据需要外网服务器进行访问
            return new NewsDto();
        } catch (Exception e) {
            log.error("requestToken失败,msg={}", e.getMessage());
            throw new RuntimeException(e.getMessage());
        }
    }
}
