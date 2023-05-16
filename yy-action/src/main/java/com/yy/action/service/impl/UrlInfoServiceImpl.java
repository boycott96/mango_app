package com.yy.action.service.impl;

import com.yy.action.entity.vo.UrlInfoVo;
import com.yy.action.service.FileService;
import com.yy.action.service.UrlInfoService;
import com.yy.common.core.constant.ExceptionConstants;
import com.yy.common.core.utils.UUID;
import lombok.extern.slf4j.Slf4j;
import org.openqa.selenium.*;
import org.springframework.stereotype.Service;
import org.springframework.util.MimeTypeUtils;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.net.URL;

/**
 * @author sunruiguang
 * @date 2023-05-16
 */
@Slf4j
@Service
public class UrlInfoServiceImpl implements UrlInfoService {
    private final FileService fileService;
    private final WebDriver driver;

    private final static String PNG_APPEND = ".png";

    public UrlInfoServiceImpl(FileService fileService, WebDriver driver) {
        this.fileService = fileService;
        this.driver = driver;
    }

    @Override
    public UrlInfoVo getUrlInfo(String url) {
        UrlInfoVo urlInfoVo = new UrlInfoVo();
        try {
            driver.get(url);
            String id = UUID.randomUUID().toString();

            // 获取网页标题
            urlInfoVo.setTitle(driver.getTitle());

            // 获取网页截图
            File screenshotFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
            BufferedImage screenshotImage = ImageIO.read(screenshotFile);
            // 保存截图
            File screenshotOutputFile = new File("/Users/sun/Downloads/temp/screen/" + id + PNG_APPEND);
            ImageIO.write(screenshotImage, MimeTypeUtils.IMAGE_PNG.getSubtype(), screenshotOutputFile);

            // 网页截图上传到minio中
            urlInfoVo.setThumbnail(fileService.uploadStream(screenshotOutputFile, MimeTypeUtils.IMAGE_PNG_VALUE));
            // 获取网页图标
            WebElement iconElement = driver.findElement(By.cssSelector("link[rel='icon'], link[rel='shortcut icon']"));
            String iconUrl = iconElement.getAttribute("href");

            // 获取图标链接
            URL iconUrlObject = new URL(iconUrl);
            urlInfoVo.setIcon(iconUrlObject.toString());
        } catch (Exception e) {
            log.error(ExceptionConstants.LOG_URL_ERROR, e);
        }
        return urlInfoVo;
    }
}
