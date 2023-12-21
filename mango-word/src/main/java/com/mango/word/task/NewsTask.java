package com.mango.word.task;

import com.mango.api.bbc.NewsService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

@RequiredArgsConstructor(onConstructor_ = {@Autowired})
public class NewsTask {

    private final NewsService newsService;

    private final String API_KEY = "1c712421229f4be991f0e4e86f8738c9";
    private final String DEFAULT_COUNTRY = "us";

    public void generateNewsDay() {
        newsService.getTopHeadlinesByCountry(DEFAULT_COUNTRY, API_KEY);
    }
}
