package com.yy.action.controller;

import com.yy.action.entity.vo.UrlInfoVo;
import com.yy.action.service.UrlInfoService;
import com.yy.common.core.domain.R;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 获取URL信息的控制层
 *
 * @author sunruiguang
 * @date 2023-05-16
 */
@RestController
@RequestMapping("/url")
public class UrlInfoController {

    private final UrlInfoService urlInfoService;

    public UrlInfoController(UrlInfoService urlInfoService) {
        this.urlInfoService = urlInfoService;
    }

    @GetMapping("/info")
    public R<UrlInfoVo> getUrlInfo(@RequestParam("url") String url) {
        return R.ok(urlInfoService.getUrlInfo(url));
    }

    @GetMapping("/title")
    public R<String> getUrlTitle(@RequestParam("url") String url) {
        return R.ok(urlInfoService.getUrlTitle(url));
    }
}
