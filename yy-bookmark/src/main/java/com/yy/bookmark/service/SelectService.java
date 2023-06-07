package com.yy.bookmark.service;

import com.yy.bookmark.entity.vo.SelectVo;

import java.util.List;

public interface SelectService {

    List<SelectVo> selectList(String path, String searchValue);
}
