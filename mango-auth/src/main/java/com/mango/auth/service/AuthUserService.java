package com.mango.auth.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mango.api.entity.AuthUser;
import com.mango.api.model.LoginUser;
import com.mango.auth.entity.ro.LoginBody;
import com.mango.auth.entity.ro.UserRo;

/**
 * @author sunruiguang
 * @date 2022-11-14
 */
public interface AuthUserService extends IService<AuthUser> {
}
