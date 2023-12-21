package com.mango.api.bbc.dto;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class NewsDto {

    private String status;

    private int totalResults;
}
