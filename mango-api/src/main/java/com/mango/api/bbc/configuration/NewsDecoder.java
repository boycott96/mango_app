package com.mango.api.bbc.configuration;

import com.alibaba.fastjson2.JSON;
import com.mango.api.bbc.dto.NewsDto;
import com.mango.api.wechat.vo.WechatSessionVo;
import com.mango.api.wechat.vo.WechatUserInfo;
import feign.FeignException;
import feign.Response;
import feign.Util;
import feign.codec.DecodeException;
import feign.codec.Decoder;
import org.springframework.http.HttpStatus;

import java.io.IOException;
import java.lang.reflect.Type;

import static com.mango.common.core.text.StrFormatter.format;

public class NewsDecoder implements Decoder {
    @Override
    public Object decode(Response response, Type type) throws IOException, FeignException {
        Response.Body body = response.body();
        if (response.status() == HttpStatus.OK.value()) {
            if (body == null) {
                return null;
            }
            String bodyString = Util.toString(body.asReader(Util.UTF_8));
            if (NewsDto.class.getName().equals(type.getTypeName())) {
                return JSON.parseObject(bodyString, NewsDto.class);
            }
        }
        throw new DecodeException(response.status(),
                format("%s is not a type supported by this decoder.", type),
                response.request());
    }
}
