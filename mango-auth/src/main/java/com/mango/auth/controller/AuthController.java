package com.mango.auth.controller;

import com.alibaba.nacos.plugin.auth.constant.Constants;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.mango.api.entity.AuthUser;
import com.mango.api.model.LoginUser;
import com.mango.api.wechat.WechatService;
import com.mango.api.wechat.configuration.WechatMiniProgramProperties;
import com.mango.api.wechat.vo.WechatSessionVo;
import com.mango.auth.entity.EmailDetails;
import com.mango.auth.entity.enums.CheckUniqueTypeEnum;
import com.mango.auth.entity.ro.LoginBody;
import com.mango.auth.entity.ro.UserRo;
import com.mango.auth.entity.ro.VerifyRo;
import com.mango.auth.entity.vo.UserVo;
import com.mango.auth.service.AuthUserService;
import com.mango.auth.service.EmailService;
import com.mango.auth.service.TokenService;
import com.mango.common.core.constant.ExceptionConstants;
import com.mango.common.core.domain.R;
import com.mango.common.core.exception.ServiceException;
import com.mango.common.core.utils.StringUtils;
import com.mango.common.redis.service.RedisService;
import com.mango.common.security.auth.AuthUtil;
import com.mango.common.security.utils.SecurityUtils;
import io.jsonwebtoken.lang.Assert;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

/**
 * @author sunruiguang
 * @date 2022-11-14
 */
@RestController
@RequestMapping()
@RequiredArgsConstructor(onConstructor_ = {@Autowired})
public class AuthController {

    private final AuthUserService authUserService;
    private final TokenService tokenService;
    private final WechatMiniProgramProperties wechatMiniProgramProperties;
    private final WechatService wechatService;

    /**
     * 微信登录用户
     */
    @PostMapping(value = "/login/wechat")
    public R<?> wechatLogin(@RequestParam("code") String code) {
        Assert.isTrue(StringUtils.isNotBlank(code), code);
        WechatSessionVo authorizationCode = wechatService.jscode2session(wechatMiniProgramProperties.getAppId(),
                wechatMiniProgramProperties.getAppSecret(), code, "authorization_code");
        // 根据openId查询数据库中是否存在，若不存在则进行创建
        String openid = authorizationCode.getOpenid();
        AuthUser one = authUserService.getOne(Wrappers.<AuthUser>lambdaQuery().eq(AuthUser::getOpenId, openid));
        if (Objects.isNull(one)) {
            one = new AuthUser();
            one.setOpenId(openid);
            authUserService.save(one);
        }
        // 存在则返回数据库中的用户信息
        // 创建token
        LoginUser loginUser = new LoginUser();
        loginUser.setAuthUser(one);
        return R.ok(tokenService.createToken(loginUser));
    }

    @PutMapping("/wechat")
    public R<?> wechat(@RequestBody AuthUser authUser) {
        Assert.isTrue(StringUtils.isNotBlank(authUser.getUsername()));
        LoginUser loginUser = SecurityUtils.getLoginUser();
        AuthUser one = authUserService.getById(loginUser.getId());
        one.setUsername(authUser.getUsername());
        one.setAvatarUrl(authUser.getAvatarUrl());
        authUserService.updateById(one);
        return R.ok();
    }

    @GetMapping("/info")
    public R<AuthUser> getInfo() {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        AuthUser user = authUserService.getById(loginUser.getId());
        Assert.notNull(user, "账号不存在, 请重新登录");
        return R.ok(user);
    }

}
