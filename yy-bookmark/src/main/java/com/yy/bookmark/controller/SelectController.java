package com.yy.bookmark.controller;

import com.yy.bookmark.entity.vo.SelectVo;
import com.yy.bookmark.service.SelectService;
import com.yy.common.core.domain.R;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author sunruiguang
 * @date 2023-06-02
 */
@RestController
@RequestMapping("/select")
public class SelectController {

    private final SelectService selectService;

    public SelectController(SelectService selectService) {
        this.selectService = selectService;
    }

    @GetMapping("/{path}")
    public R<List<SelectVo>> selectList(@PathVariable("path") String path, String searchValue) {
        return R.ok(selectService.selectList(path, searchValue));
    }
}
