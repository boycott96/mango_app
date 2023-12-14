package com.mango.word.util;

import com.alibaba.fastjson2.JSONObject;
import io.micrometer.core.instrument.util.IOUtils;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

@Component
public class ImportWordBook {

    public void importBook(String fileName) {
        // 读取文件路径
        try {
            String bookStr = IOUtils.toString(new FileInputStream(fileName), StandardCharsets.UTF_8);
            // 再将bookStr，转化为Json
            JSONObject jsonObject = JSONObject.parseObject(bookStr);
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
