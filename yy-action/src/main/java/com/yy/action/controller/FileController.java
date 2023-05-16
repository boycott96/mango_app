package com.yy.action.controller;

import com.yy.action.service.FileService;
import com.yy.common.core.domain.R;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author sunruiguang
 * @date 2023-05-16
 */
@RestController
@Slf4j
@RequestMapping("/file")
public class FileController {

    private final FileService fileService;

    public FileController(FileService fileService) {
        this.fileService = fileService;
    }

    /**
     * 上传文件转化为url
     *
     * @param file 上传的文件
     * @return com.yy.common.core.domain.R<?>
     * @author sunruiguang
     * @since 2023/5/16
     */
    @PostMapping("/upload")
    public R<?> upload(MultipartFile file) {
        try {
            return R.ok(fileService.uploadFile(file));
        } catch (Exception e) {
            log.error("上传文件失败", e);
            return R.fail(e.getMessage());
        }
    }
}
