package com.yy.action.service.impl;

import com.yy.action.entity.po.ActionImportLog;
import com.yy.action.service.ActionImportLogService;
import com.yy.action.service.LogService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.exception.ServiceException;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Objects;

/**
 * @author sunruiguang
 * @date 2023-04-28
 */
@Service
public class LogServiceImpl implements LogService {

    private final ActionImportLogService actionImportLogService;

    public LogServiceImpl(ActionImportLogService actionImportLogService) {
        this.actionImportLogService = actionImportLogService;
    }

    @Override
    public ActionImportLog getByLogId(Long logId) {
        // 查询对应的日志数据
        ActionImportLog importLog = actionImportLogService.getById(logId);
        ServiceException.isTrue(Objects.isNull(importLog), ExceptionConstants.NOT_FOUND_DATA);
        return importLog;
    }

    @Override
    public Long add(String fileName, Long userId) {
        // 插入日志数据
        ActionImportLog importLog = new ActionImportLog();
        importLog.setFileName(fileName);
        importLog.setCreateBy(userId);
        importLog.setCreateTime(new Date());
        actionImportLogService.save(importLog);
        return importLog.getId();
    }

    @Override
    public void updateProgress(Long logId, int num) {
        ActionImportLog log = actionImportLogService.getById(logId);
        log.setProgress(num);
        actionImportLogService.updateById(log);
    }
}
