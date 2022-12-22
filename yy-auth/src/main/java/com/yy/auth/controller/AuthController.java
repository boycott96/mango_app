package com.yy.auth.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yy.api.domain.YyUser;
import com.yy.api.model.LoginUser;
import com.yy.auth.domain.EmailDetails;
import com.yy.auth.domain.enums.CheckUniqueTypeEnum;
import com.yy.auth.domain.ro.LoginBody;
import com.yy.auth.domain.ro.UserRo;
import com.yy.auth.domain.vo.UserVo;
import com.yy.auth.service.EmailService;
import com.yy.auth.service.TokenService;
import com.yy.auth.service.YyUserService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.domain.R;
import com.yy.common.core.exception.ServiceException;
import com.yy.common.core.utils.StringUtils;
import com.yy.common.redis.service.RedisService;
import com.yy.common.security.auth.AuthUtil;
import com.yy.common.security.utils.SecurityUtils;
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

    private final YyUserService yyUserService;
    private final TokenService tokenService;
    private final EmailService emailService;
    private final RedisService redisService;

    public AuthController(YyUserService yyUserService, TokenService tokenService, EmailService emailService, RedisService redisService) {
        this.yyUserService = yyUserService;
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
        yyUserService.register(userRo);
        return R.ok();
    }

    @PostMapping(value = "/send/code")
    public R<?> sendCode(@RequestParam(name = "email") String email) {
        // 判断email是否已经注册
        LambdaQueryWrapper<YyUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(YyUser::getEmail, email);
        YyUser one = yyUserService.getOne(queryWrapper);

        ServiceException.isTrue(Objects.nonNull(one), ExceptionConstants.EMAIL_NOT_UNIQUE);

        int i = RandomUtils.nextInt(100000, 999999);
        // 设置缓存
        redisService.setCacheObject(email, String.valueOf(i), 30L, TimeUnit.MINUTES);

        Map<String, Object> model = new HashMap<>();
        model.put("verificationCode", String.valueOf(i));

        EmailDetails emailDetails = new EmailDetails();
        emailDetails.setRecipient(email);
        emailDetails.setMsgBody(emailService.getContentFromTemplate(model));
        emailDetails.setSubject("感谢注册椰羊空间，您的验证码是：" + i);
        emailService.sendMailWithAttachment(emailDetails);
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
        LoginUser login = yyUserService.login(loginBody);
        return R.ok(tokenService.createToken(login));
    }

    /**
     * 退出登录
     *
     * @param request 页面请求
     * @return com.yy.common.core.domain.R<?>
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
     * 判断当前值是否唯一
     *
     * @param code  校验参数类型
     * @param value 校验值
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2022/11/29
     */
    @GetMapping(value = "/check/unique")
    public R<?> checkUnique(@RequestParam("code") int code, @RequestParam("value") String value) {
        CheckUniqueTypeEnum checkUniqueTypeEnum = CheckUniqueTypeEnum.ofCode(code);
        ServiceException.isTrue(Objects.isNull(checkUniqueTypeEnum), ExceptionConstants.ENUM_VALID);
        QueryWrapper<YyUser> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq(checkUniqueTypeEnum.getFieldName(), value);
        YyUser one = yyUserService.getOne(queryWrapper);
        ServiceException.isTrue(Objects.nonNull(one), checkUniqueTypeEnum.getMsg());
        return R.ok();
    }

    /**
     * 查询当前登录信息数据
     *
     * @return com.yy.common.core.domain.R<com.yy.auth.domain.vo.UserVo>
     * @author sunruiguang
     * @since 2022/11/29
     */
    @GetMapping(value = "/user/info")
    public R<UserVo> getUserInfo() {
        Long userId = SecurityUtils.getUserId();
        LambdaQueryWrapper<YyUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(YyUser::getId, userId);
        YyUser one = yyUserService.getOne(queryWrapper);
        UserVo userVo = new UserVo(one.getEmail(), one.getUsername(), one.getAvatarUrl(), one.getPhoneNumber());
        return R.ok(userVo);
    }
}
