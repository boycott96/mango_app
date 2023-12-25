package com.mango.word.task;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.date.DateUtil;
import com.mango.api.bbc.NewsService;
import com.mango.api.bbc.dto.NewsDto;
import com.mango.word.entity.NewsData;
import com.mango.word.service.NewsDataService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.Objects;

@Component
@Slf4j
@RequiredArgsConstructor(onConstructor_ = {@Autowired})
public class NewsTask {

    private final NewsService newsService;

    private final NewsDataService newsDataService;

    @Scheduled(cron = "00 00 6 * * ? ")
    public void generateNewsDay() {
        NewsDto newsDto = newsService.getTopHeadlinesByCountry();
        if (Objects.nonNull(newsDto) && CollectionUtil.isNotEmpty(newsDto.getArticles())) {
            List<NewsData> newsDataList = newsDto.getArticles().stream().map(item -> {
                NewsData newsData = new NewsData();
                BeanUtils.copyProperties(item, newsData);
                if (Objects.nonNull(item.getSource())) {
                    newsData.setSourceName(item.getSource().getName());
                }
                if (Objects.nonNull(item.getPublishedAt())) {
                    newsData.setPublishedAt(DateUtil.parse(item.getPublishedAt()));
                    newsData.setDateTimeStr(DateUtil.formatDate(newsData.getPublishedAt()));
                }
                newsData.setCreateTime(new Date());
                return newsData;
            }).toList();
            newsDataService.saveBatch(newsDataList);
        }
    }
}
