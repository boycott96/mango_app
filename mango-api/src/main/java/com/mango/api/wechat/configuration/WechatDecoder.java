package com.mango.api.wechat.configuration;

import com.alibaba.fastjson2.JSON;
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

/**
 * @author yemingxing
 * @date 2022-08-09
 */
public class WechatDecoder implements Decoder {

    @Override
    public Object decode(Response response, Type type) throws IOException, FeignException {
        Response.Body body = response.body();
        if (response.status() == HttpStatus.NOT_FOUND.value() || response.status() == HttpStatus.NO_CONTENT.value()) {
            return Util.emptyValueOf(type);
        }
        if (body == null) {
            return null;
        }
        String bodyString = Util.toString(body.asReader(Util.UTF_8));
        if (WechatSessionVo.class.getName().equals(type.getTypeName())) {
            return JSON.parseObject(bodyString, WechatSessionVo.class);
        } else if (WechatUserInfo.class.getName().equals(type.getTypeName())) {
            return JSON.parseObject(bodyString, WechatUserInfo.class);
        }
        throw new DecodeException(response.status(),
                format("%s is not a type supported by this decoder.", type),
                response.request());
    }
}
