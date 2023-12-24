package com.mango.api.bbc.dto;


import lombok.Data;

import java.util.List;

@Data
public class NewsDto {

    private String status;

    private int totalResults;

    private List<NewsArticle> articles;
}
