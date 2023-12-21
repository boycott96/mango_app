package com.mango.api.bbc;

import com.mango.api.bbc.configuration.NewsConfiguration;
import com.mango.api.bbc.dto.NewsDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "newsService", url = "https://newsapi.org/v2/", configuration = {NewsConfiguration.class})
public interface NewsService {

    @GetMapping("/top-headlines")
    NewsDto getTopHeadlinesByCountry(@RequestParam("country") String country,
                                     @RequestParam("apiKey") String apiKey);

}
