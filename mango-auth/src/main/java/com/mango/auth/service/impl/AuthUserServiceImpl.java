package com.mango.auth.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mango.api.entity.AuthUser;
import com.mango.auth.mapper.AuthUserMapper;
import com.mango.auth.service.AuthUserService;
import org.springframework.stereotype.Service;

/**
 * @author sunruiguang
 * @date 2022-11-14
 */
@Service
public class AuthUserServiceImpl extends ServiceImpl<AuthUserMapper, AuthUser> implements AuthUserService {
}
