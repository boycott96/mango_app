package com.yy.auth.controller;

import com.yy.api.entity.AuthUser;
import com.yy.auth.service.AuthUserService;
import com.yy.common.core.domain.R;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author sunruiguang
 * @date 2023-05-23
 */
@RestController
@RequestMapping("/user")
public class AuthUserController {

    private final AuthUserService authUserService;

    public AuthUserController(AuthUserService authUserService) {
        this.authUserService = authUserService;
    }


    /**
     * 批量查询用户信息数据
     *
     * @param ids 用户ID集合
     * @return com.yy.common.core.domain.R<java.util.List < com.yy.api.entity.AuthUser>>
     * @author sunruiguang
     * @since 2023/5/23
     */
    @GetMapping(value = "/batch/info")
    public R<List<AuthUser>> getUserByIds(@RequestParam("ids") List<Long> ids) {
        return R.ok(authUserService.listByIds(ids));
    }
}
