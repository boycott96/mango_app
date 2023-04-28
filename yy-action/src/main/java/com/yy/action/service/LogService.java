package com.yy.action.service;

import com.yy.action.entity.po.ActionImportLog;

/**
 * @author sunruiguang
 * @date 2023-04-28
 */
public interface LogService {

    /**
     * 查询日志详情数据
     *
     * @param logId 日志ID
     * @return com.yy.action.entity.po.ActionImportLog
     * @author sunruiguang
     * @since 2023/4/28
     */
    ActionImportLog getByLogId(Long logId);

    /**
     * 插入日志数据
     *
     * @param fileName 导入的文件名称
     * @param userId   用户ID
     * @author sunruiguang
     * @since 2023/4/28
     */
    Long add(String fileName, Long userId);

    /**
     * 对进度进行更新
     *
     * @param logId 日志ID
     * @param num   进度
     * @author sunruiguang
     * @since 2023/4/28
     */
    void updateProgress(Long logId, int num);
}
