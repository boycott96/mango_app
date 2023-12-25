package com.mango.word.mapper;

import com.mango.word.entity.NewsData;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
* @author boycott
* @description 针对表【news_data(新闻数据记录)】的数据库操作Mapper
* @createDate 2023-12-26 00:09:07
* @Entity com.mango.word.entity.NewsData
*/
@Mapper
public interface NewsDataMapper extends BaseMapper<NewsData> {

}




