package com.yy.auth.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yy.api.domain.YyUser;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface YyUserMapper extends BaseMapper<YyUser> {
}
