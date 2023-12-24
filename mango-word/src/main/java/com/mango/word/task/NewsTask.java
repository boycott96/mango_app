package com.mango.word.task;

import com.mango.api.bbc.NewsService;
import com.mango.api.bbc.dto.NewsDto;
import com.mango.word.util.ApplicationContextUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.annotation.PostConstruct;

//@RestController
//@RequestMapping("/task")
@Component
@Slf4j
public class NewsTask {

    @Autowired
    private  NewsService newsService;

//    @Scheduled(cron = "30 47 9 * * ? ")
    @Scheduled(fixedDelay = 2)
//    @GetMapping("/news")
    public void generateNewsDay() {
        NewsDto newsDto = newsService.getTopHeadlinesByCountry();
        log.info(newsDto.toString());
    }
}
