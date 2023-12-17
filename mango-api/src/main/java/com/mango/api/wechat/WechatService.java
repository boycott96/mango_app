package com.mango.api.wechat;

import com.mango.api.wechat.configuration.WechatConfiguration;
import com.mango.api.wechat.vo.WechatSessionVo;
import com.mango.api.wechat.vo.WechatUserInfo;
import com.mango.common.core.constant.CacheConstants;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "wechatService", url = "https://api.weixin.qq.com", configuration = {WechatConfiguration.class})
public interface WechatService {

    /**
     * 根据微信小程序临时登录凭证code获取用户Session信息
     * 40029	code 无效	                                                    js_code无效
     * 45011	api minute-quota reach limit mustslower  retry next minute	    API 调用太频繁，请稍候再试
     * 40226	code blocked	                                                高风险等级用户，小程序登录拦截 。风险等级详见用户安全解方案
     * -1	    system error	                                                系统繁忙，此时请开发者稍候再试
     *
     * @param js_code    登录时获取的 code，可通过wx.login获取
     * @param grant_type 授权类型，此处只需填写 authorization_code
     * @return java.lang.String
     */
    @GetMapping("/sns/jscode2session")
    @Cacheable(value = CacheConstants.R_CACHE_NAME_10MIN)
    WechatSessionVo jscode2session(@RequestParam("appid") String appid,
                                   @RequestParam("secret") String appsecret,
                                   @RequestParam("js_code") String js_code,
                                   @RequestParam(value = "grant_type", defaultValue = "authorization_code") String grant_type);

}
