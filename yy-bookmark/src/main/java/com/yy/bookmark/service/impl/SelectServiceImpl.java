package com.yy.bookmark.service.impl;

import com.yy.bookmark.entity.vo.SelectVo;
import com.yy.bookmark.enums.SelectEnum;
import com.yy.bookmark.mapper.SelectMapper;
import com.yy.bookmark.service.SelectService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.exception.ServiceException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

/**
 * @author sunruiguang
 * @date 2023-06-02
 */
@Service
public class SelectServiceImpl implements SelectService {

    private final SelectMapper selectMapper;

    public SelectServiceImpl(SelectMapper selectMapper) {
        this.selectMapper = selectMapper;
    }

    @Override
    public List<SelectVo> selectList(String path, String searchValue) {
        SelectEnum selectEnum = SelectEnum.getByPath(path);
        ServiceException.isTrue(Objects.isNull(selectEnum), ExceptionConstants.PARAM_INVALID);
        return selectMapper.getDataByTableAndColumn(selectEnum.getTableName(), selectEnum.getLabelColumn(), selectEnum.getValueColumn(), searchValue);
    }
}
