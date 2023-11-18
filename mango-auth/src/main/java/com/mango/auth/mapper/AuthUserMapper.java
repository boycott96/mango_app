package com.mango.auth.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mango.api.entity.AuthUser;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AuthUserMapper extends BaseMapper<AuthUser> {
}
