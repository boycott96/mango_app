package com.yy.auth.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.api.domain.YyUser;
import com.yy.api.model.LoginUser;
import com.yy.auth.domain.ro.LoginBody;
import com.yy.auth.domain.ro.UserRo;
import com.yy.auth.mapper.YyUserMapper;
import com.yy.auth.service.PasswordService;
import com.yy.auth.service.YyUserService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.exception.ServiceException;
import com.yy.common.security.utils.SecurityUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Objects;

/**
 * @author sunruiguang
 * @date 2022-11-14
 */
@Service
public class YyUserServiceImpl extends ServiceImpl<YyUserMapper, YyUser> implements YyUserService {

    private final YyUserMapper yyUserMapper;
    private final PasswordService passwordService;

    public YyUserServiceImpl(YyUserMapper yyUserMapper, PasswordService passwordService) {
        this.yyUserMapper = yyUserMapper;
        this.passwordService = passwordService;
    }

    @Override
    public void register(UserRo userRo) {
        // 校验邮箱，用户名，和手机号码是否唯一
        LambdaQueryWrapper<YyUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(YyUser::getEmail, userRo.getEmail());
        YyUser emailUniqueBean = yyUserMapper.selectOne(queryWrapper);
        ServiceException.isTrue(Objects.nonNull(emailUniqueBean), ExceptionConstants.EMAIL_NOT_UNIQUE);
        queryWrapper.clear();
        queryWrapper.eq(YyUser::getUsername, userRo.getUsername());
        YyUser usernameUniqueBean = yyUserMapper.selectOne(queryWrapper);
        ServiceException.isTrue(Objects.nonNull(usernameUniqueBean), ExceptionConstants.USERNAME_NOT_UNIQUE);

        YyUser yyUser = new YyUser();
        BeanUtils.copyProperties(userRo, yyUser);
        // 设置密码加密
        yyUser.setPassword(SecurityUtils.encryptPassword(userRo.getPassword()));
        yyUser.setCreateTime(new Date());
        yyUserMapper.insert(yyUser);
    }

    @Override
    public LoginUser login(LoginBody loginBody) {
        // 查询
        LambdaQueryWrapper<YyUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(YyUser::getEmail, loginBody.getEmail());
        YyUser yyUser = yyUserMapper.selectOne(wrapper);
        ServiceException.isTrue(Objects.isNull(yyUser), ExceptionConstants.EMAIL_USERNAME_INVALID);
        ServiceException.isTrue(!SecurityUtils.matchesPassword(loginBody.getPassword(), yyUser.getPassword()), ExceptionConstants.PWD_ERROR);
        LoginUser loginUser = new LoginUser();
        loginUser.setYyUser(yyUser);
        passwordService.validate(yyUser, loginBody.getPassword());
        return loginUser;
    }
}
