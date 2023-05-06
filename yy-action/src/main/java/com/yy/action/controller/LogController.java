package com.yy.action.controller;

import com.yy.action.service.LogService;
import com.yy.common.core.domain.R;
import org.springframework.web.bind.annotation.*;

/**
 * @author sunruiguang
 * @date 2023-04-28
 */
@RestController()
@RequestMapping("/log")
public class LogController {

    private final LogService logService;

    public LogController(LogService logService) {
        this.logService = logService;
    }

    /**
     * 插入日志
     *
     * @param fileName 文件名称
     * @param userId   用户ID
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/4/28
     */
    @PostMapping("/add")
    public R<Long> addLogData(@RequestParam("fileName") String fileName, @RequestParam("userId") Long userId) {
        return R.ok(logService.add(fileName, userId));
    }

    /**
     * 获取日志详情数据
     *
     * @param logId 日志ID
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/4/28
     */
    @GetMapping("/{logId}")
    public R<?> getLogInfo(@PathVariable("logId") Long logId) {
        return R.ok(logService.getByLogId(logId));
    }

    /**
     * 对进度进行更新
     *
     * @param logId 日志ID
     * @param num   进度
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/4/28
     */
    @PutMapping("/update/progress")
    public R<?> updateProgress(@RequestParam("logId") Long logId, @RequestParam("progress") int num) {
        logService.updateProgress(logId, num);
        return R.ok();
    }
}
