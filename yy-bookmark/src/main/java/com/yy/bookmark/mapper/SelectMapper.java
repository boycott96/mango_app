package com.yy.bookmark.mapper;

import com.yy.bookmark.entity.vo.SelectVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SelectMapper {

    /**
     * 查询对应表和列的数据
     *
     * @param tableName   表名
     * @param labelColumn 标签字段
     * @param valueColumn key字段
     * @param searchValue 搜索值
     * @return java.util.List<com.yy.bookmark.entity.vo.SelectVo>
     * @author sunruiguang
     * @since 2023/6/2
     */
    List<SelectVo> getDataByTableAndColumn(@Param("tableName") String tableName,
                                           @Param("labelColumn") String labelColumn,
                                           @Param("valueColumn") String valueColumn,
                                           @Param("searchValue") String searchValue);
}
