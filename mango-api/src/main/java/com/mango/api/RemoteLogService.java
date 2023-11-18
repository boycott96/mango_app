package com.mango.api;

import com.mango.common.core.constant.ServiceNameConstants;
import com.mango.common.core.domain.R;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(contextId = "remoteLogService", value = ServiceNameConstants.ACTION_SERVICE)
public interface RemoteLogService {

    /**
     * 添加日志
     *
     * @param fileName 日志名称
     * @param userId   用户ID
     * @return com.mango.common.core.domain.R<java.lang.Long>
     * @author sunruiguang
     * @since 2023/4/30
     */
    @PostMapping("/log/add")
    R<Long> addLog(@RequestParam("fileName") String fileName, @RequestParam("userId") Long userId);

    /**
     * 更新日志的进度
     *
     * @param logId    日志ID
     * @param progress 日志进度
     * @return com.mango.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/4/30
     */
    @PutMapping("/log/update/progress")
    R<?> updateLogProgress(@RequestParam("logId") Long logId, @RequestParam("progress") int progress);
}
