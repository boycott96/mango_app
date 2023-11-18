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

    /**
     * 注册实现
     *
     * @param userRo 用户请求数据
     */
    void register(UserRo userRo);

    /**
     * 登录数据
     *
     * @param loginBody 登录参数
     * @return 返回结果
     */
    LoginUser login(LoginBody loginBody);
}
