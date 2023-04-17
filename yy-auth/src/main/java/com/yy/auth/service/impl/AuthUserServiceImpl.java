package com.yy.auth.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.api.entity.AuthUser;
import com.yy.api.model.LoginUser;
import com.yy.auth.entity.ro.LoginBody;
import com.yy.auth.entity.ro.UserRo;
import com.yy.auth.mapper.AuthUserMapper;
import com.yy.auth.service.AuthUserService;
import com.yy.auth.service.PasswordService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.exception.ServiceException;
import com.yy.common.redis.service.RedisService;
import com.yy.common.security.utils.SecurityUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

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
        authUser.setPassword(SecurityUtils.encryptPassword(userRo.getPassword()));
        authUserMapper.insert(authUser);
        redisService.deleteObject(userRo.getEmail());
    }

    @Override
    public LoginUser login(LoginBody loginBody) {
        // 查询
        LambdaQueryWrapper<AuthUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AuthUser::getEmail, loginBody.getEmail());
        AuthUser authUser = authUserMapper.selectOne(wrapper);
        ServiceException.isTrue(Objects.isNull(authUser), ExceptionConstants.EMAIL_NO_EXIST);
        ServiceException.isTrue(!SecurityUtils.matchesPassword(loginBody.getPassword(), authUser.getPassword()), ExceptionConstants.PWD_ERROR);
        LoginUser loginUser = new LoginUser();
        loginUser.setAuthUser(authUser);
        passwordService.validate(authUser, loginBody.getPassword());
        return loginUser;
    }
}
