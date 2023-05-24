package com.yy.api;

import com.yy.api.entity.AuthUser;
import com.yy.common.core.constant.ServiceNameConstants;
import com.yy.common.core.domain.R;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(contextId = "remoteAuthUserService", value = ServiceNameConstants.AUTH_SERVICE)
public interface RemoteAuthUserService {

    /**
     * 批量查阅用户信息
     *
     * @param ids 用户ID集合
     * @return com.yy.common.core.domain.R<java.util.List < com.yy.api.entity.AuthUser>>
     * @author sunruiguang
     * @since 2023/5/23
     */
    @GetMapping("/user/batch/info")
    R<List<AuthUser>> getUserByIds(@RequestParam("ids") List<Long> ids);
}
