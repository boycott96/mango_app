package com.yy.action.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.action.entity.po.ActionImportLog;
import com.yy.action.mapper.ActionImportLogMapper;
import com.yy.action.service.ActionImportLogService;
import org.springframework.stereotype.Service;

/**
 * @author sunruiguang
 * @date 2023-05-06
 */
@Service
public class ActionImportLogServiceImpl extends ServiceImpl<ActionImportLogMapper, ActionImportLog> implements ActionImportLogService {
}
