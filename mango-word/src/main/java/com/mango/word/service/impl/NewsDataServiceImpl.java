package com.mango.word.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mango.word.entity.NewsData;
import com.mango.word.service.NewsDataService;
import com.mango.word.mapper.NewsDataMapper;
import org.springframework.stereotype.Service;

/**
* @author boycott
* @description 针对表【news_data(新闻数据记录)】的数据库操作Service实现
* @createDate 2023-12-26 00:09:07
*/
@Service
public class NewsDataServiceImpl extends ServiceImpl<NewsDataMapper, NewsData>
    implements NewsDataService{

}




