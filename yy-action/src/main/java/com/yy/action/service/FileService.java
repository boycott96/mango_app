package com.yy.action.service;

import com.yy.action.config.MinioConfig;
import com.yy.common.core.utils.DateUtils;
import com.yy.common.core.utils.IdUtils;
import com.yy.common.core.utils.StringUtils;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.util.Date;

@Service
public class FileService {

    private final MinioConfig minioConfig;

    private final MinioClient minioClient;

    public FileService(MinioConfig minioConfig, MinioClient minioClient) {
        this.minioConfig = minioConfig;
        this.minioClient = minioClient;
    }

    /**
     * 上传文件到minio
     *
     * @param file 文件
     * @return java.lang.String
     * @author sunruiguang
     * @since 2023/5/16
     */
    public String uploadFile(MultipartFile file) throws Exception {
        String filename = extractFilename(file);
        minioClient.putObject(PutObjectArgs.builder().bucket(minioConfig.getBucketName()).object(filename)
                .stream(file.getInputStream(), file.getSize(), -1).contentType(file.getContentType()).build());
        return minioConfig.getUrl() + "/" + minioConfig.getBucketName() + "/" + filename;
    }

    /**
     * 上传文件流到minio中
     *
     * @param file        文件
     * @param contentType 文件类型
     * @return java.lang.String
     * @author sunruiguang
     * @since 2023/5/16
     */
    public String uploadStream(File file, String contentType) throws Exception {
        String filename = extractFilename(file);
        minioClient.putObject(PutObjectArgs.builder().bucket(minioConfig.getBucketName()).object(filename)
                .stream(new FileInputStream(file), file.length(), -1).contentType(contentType).build());
        return minioConfig.getUrl() + "/" + minioConfig.getBucketName() + "/" + filename;
    }

    /**
     * 抽取文件名
     *
     * @param file 文件
     * @return java.lang.String
     * @author sunruiguang
     * @since 2023/5/16
     */
    public String extractFilename(MultipartFile file) {
        String extension = getExtension(file);
        StringBuilder filename = new StringBuilder();
        if (file.getOriginalFilename() == null) {
            filename.append(IdUtils.fastUUID());
        } else {
            filename.append(StringUtils.substring(file.getOriginalFilename(), 0, 10)).append(new Date().getTime());
        }
        return DateUtils.nowDateTimeStr(DateUtils.VIRGULE_YYYY_MM_DD) + "/" + filename + "." + extension;
    }

    public String extractFilename(File file) {
        return extractFilename(file.getName());
    }

    public String extractFilename(String originFilename) {
        String filename = StringUtils.substring(originFilename, 0, 10) + new Date().getTime();
        return DateUtils.nowDateTimeStr(DateUtils.VIRGULE_YYYY_MM_DD) + "/" + filename + "." + FilenameUtils.getExtension(originFilename);
    }


    /**
     * 获取文件名的后缀
     *
     * @param file 表单文件
     * @return java.lang.String
     * @author sunruiguang
     * @since 2023/5/16
     */
    public String getExtension(MultipartFile file) {
        return StringUtils.defaultIfBlank(FilenameUtils.getExtension(file.getOriginalFilename()), "");
    }
}
