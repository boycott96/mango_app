package com.mango.auth.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mango.api.entity.AuthUser;
import com.mango.api.model.LoginUser;
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
import org.apache.commons.lang3.RandomUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

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
public class AuthController {

    private final AuthUserService authUserService;
    private final TokenService tokenService;
    private final EmailService emailService;
    private final RedisService redisService;

    public AuthController(AuthUserService authUserService,
                          TokenService tokenService,
                          EmailService emailService,
                          RedisService redisService) {
        this.authUserService = authUserService;
        this.tokenService = tokenService;
        this.emailService = emailService;
        this.redisService = redisService;
    }

    /**
     * 注册用户
     *
     * @param userRo 注册数据
     * @return 返回注册结果
     */
    @PostMapping(value = "/register")
    public R<?> register(@RequestBody @Validated UserRo userRo) {
        // 校验邮箱，用户名是否唯一
        LambdaQueryWrapper<AuthUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AuthUser::getEmail, userRo.getEmail());
        queryWrapper.or().eq(AuthUser::getUsername, userRo.getUsername());
        AuthUser bean = authUserService.getOne(queryWrapper);
        ServiceException.isTrue(Objects.nonNull(bean), ExceptionConstants.PARAM_INVALID);
        this.sendVerifyCode(userRo);
        return R.ok();
    }

    /**
     * @param type CheckUniqueTypeEnum 1: email, 2: username
     * @return com.mango.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/4/18
     */
    @GetMapping(value = "/check/unique")
    public R<?> verifyEmail(@RequestParam("value") String value, @RequestParam("type") int type) {
        LambdaQueryWrapper<AuthUser> queryWrapper = new LambdaQueryWrapper<>();
        if (type == CheckUniqueTypeEnum.EMAIL_CHECK.getCode()) {
            queryWrapper.eq(AuthUser::getEmail, value);
        } else {
            queryWrapper.eq(AuthUser::getUsername, value);
        }
        AuthUser bean = authUserService.getOne(queryWrapper);
        ServiceException.isTrue(Objects.nonNull(bean),
                type == CheckUniqueTypeEnum.EMAIL_CHECK.getCode() ?
                        ExceptionConstants.EMAIL_NOT_UNIQUE : ExceptionConstants.USERNAME_NOT_UNIQUE);
        return R.ok();
    }

    @PostMapping(value = "/verify")
    public R<?> verify(@Validated @RequestBody VerifyRo verifyRo) {
        // 校验验证码是否符合规定
        UserRo userRo = redisService.getCacheObject(verifyRo.getEmail());
        ServiceException.isTrue(Objects.isNull(userRo) || !verifyRo.getVerifyCode().equals(userRo.getVerifyCode()), ExceptionConstants.AUTH_CODE_INVALID);
        authUserService.register(userRo);
        return R.ok();
    }

    @GetMapping(value = "/resend")
    public R<?> resend(@RequestParam String email) {
        UserRo userRo = redisService.getCacheObject(email);
        ServiceException.isTrue(Objects.isNull(userRo), ExceptionConstants.REGISTER_INFO_INVALID);
        this.sendVerifyCode(userRo);
        return R.ok();
    }

    /**
     * 登录用户
     *
     * @param loginBody 用户数据
     * @return 返回登录结果
     */
    @PostMapping(value = "/login")
    public R<?> login(@RequestBody @Validated LoginBody loginBody) {
        LoginUser login = authUserService.login(loginBody);
        return R.ok(tokenService.createToken(login, loginBody.isRemember()));
    }

    /**
     * 退出登录
     *
     * @param request 页面请求
     * @return com.mango.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2022/11/27
     */
    @DeleteMapping(value = "/logout")
    public R<?> logout(HttpServletRequest request) {
        String token = SecurityUtils.getToken(request);
        if (StringUtils.isNotEmpty(token)) {
            AuthUtil.logoutByToken(token);
        }
        return R.ok();
    }

    /**
     * 查询当前登录信息数据
     *
     * @return com.mango.common.core.domain.R<com.mango.auth.domain.vo.UserVo>
     * @author sunruiguang
     * @since 2022/11/29
     */
    @GetMapping(value = "/user/info")
    public R<UserVo> getUserInfo() {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        LambdaQueryWrapper<AuthUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AuthUser::getId, loginUser.getId());
        AuthUser one = authUserService.getOne(queryWrapper);
        UserVo userVo = new UserVo(one.getEmail(), one.getUsername(), one.getStageName(), one.getAvatarUrl());
        // 对token进行校验，若token 还剩两小时即将失效，则进行刷新token
        tokenService.verifyToken(loginUser);
        return R.ok(userVo);
    }

    private void sendVerifyCode(UserRo userRo) {
        int code = RandomUtils.nextInt(100000, 999999);
        userRo.setVerifyCode(String.valueOf(code));
        // 设置缓存
        redisService.setCacheObject(userRo.getEmail(), userRo, 10L, TimeUnit.MINUTES);
        Map<String, Object> model = new HashMap<>();
        model.put("verificationCode", userRo.getVerifyCode());

        EmailDetails emailDetails = new EmailDetails();
        emailDetails.setRecipient(userRo.getEmail());
        emailDetails.setMsgBody(emailService.getContentFromTemplate(model));
        emailDetails.setSubject("感谢注册椰羊空间，您的验证码是：" + userRo.getVerifyCode());
        emailService.sendMailWithAttachment(emailDetails);
    }
}
