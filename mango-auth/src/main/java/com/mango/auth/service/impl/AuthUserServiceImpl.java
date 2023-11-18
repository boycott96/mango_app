package com.mango.auth.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mango.api.entity.AuthUser;
import com.mango.api.model.LoginUser;
import com.mango.auth.entity.ro.LoginBody;
import com.mango.auth.entity.ro.UserRo;
import com.mango.auth.mapper.AuthUserMapper;
import com.mango.auth.service.AuthUserService;
import com.mango.auth.service.PasswordService;
import com.mango.common.core.constant.ExceptionConstants;
import com.mango.common.core.exception.ServiceException;
import com.mango.common.redis.service.RedisService;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Objects;

/**
 * @author sunruiguang
 * @date 2022-11-14
 */
@Service
public class AuthUserServiceImpl extends ServiceImpl<AuthUserMapper, AuthUser> implements AuthUserService {

    private final AuthUserMapper authUserMapper;
    private final PasswordService passwordService;
    private final RedisService redisService;

    public AuthUserServiceImpl(AuthUserMapper authUserMapper, PasswordService passwordService, RedisService redisService) {
        this.authUserMapper = authUserMapper;
        this.passwordService = passwordService;
        this.redisService = redisService;
    }

    @Override
    public void register(UserRo userRo) {
        AuthUser authUser = new AuthUser();
        BeanUtils.copyProperties(userRo, authUser);
        // 设置密码加密
        authUser.setPassword(userRo.getPassword());
        authUser.setCreateTime(new Date());
        authUserMapper.insert(authUser);
        redisService.deleteObject(userRo.getEmail());
    }

    @Override
    public LoginUser login(LoginBody loginBody) {
        // 查询
        LambdaQueryWrapper<AuthUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AuthUser::getEmail, loginBody.getUsername());
        wrapper.or().eq(AuthUser::getUsername, loginBody.getUsername());
        AuthUser authUser = authUserMapper.selectOne(wrapper);
        ServiceException.isTrue(Objects.isNull(authUser), ExceptionConstants.EMAIL_NO_EXIST);
        LoginUser loginUser = new LoginUser();
        loginUser.setAuthUser(authUser);
        passwordService.validate(authUser, loginBody.getPassword());
        return loginUser;
    }
}
