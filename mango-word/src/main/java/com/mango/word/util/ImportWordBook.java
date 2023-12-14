package com.mango.word.util;

import com.alibaba.fastjson2.JSONObject;
import com.mango.word.entity.Word;
import com.mango.word.entity.WordBook;
import com.mango.word.service.WordBookService;
import com.mango.word.service.WordService;
import io.jsonwebtoken.lang.Assert;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.io.*;

@Component
@RequiredArgsConstructor(onConstructor_ = {@Autowired})
public class ImportWordBook {

    private final WordService wordService;
    private final WordBookService wordBookService;

    /**
     * 替换音标中的法语
     *
     * @param input 输入语言
     * @return 返回可以支持的格式
     */
    private String replaceFran(String input) {
        String[][] frEn = {
                {"é", "e"}, {"ê", "e"}, {"è", "e"}, {"ë", "e"},
                {"à", "a"}, {"â", "a"}, {"ç", "c"}, {"î", "i"},
                {"ï", "i"}, {"ô", "o"}, {"ù", "u"}, {"û", "u"},
                {"ü", "u"}, {"ÿ", "y"}
        };

        for (String[] pair : frEn) {
            input = input.replace(pair[0], pair[1]);
        }
        return input;
    }

    /**
     * 导入单词书籍
     *
     * @param wordBook 书籍信息
     */
    @Transactional(rollbackFor = Exception.class)
    public void importBook(WordBook wordBook) {

        wordBookService.save(wordBook);

        // 读取文件路径
        try (BufferedReader br = new BufferedReader(new FileReader(wordBook.getOriginUrl()))) {
            String line;
            while ((line = br.readLine()) != null) {
                String str = replaceFran(line);
                JSONObject object = JSONObject.parse(str);
                Assert.notNull(object);
                JSONObject content = object.getJSONObject("content");
                Assert.notNull(content);
                JSONObject wordObject = content.getJSONObject("word");
                JSONObject contentObject = wordObject.getJSONObject("content");

                Word word = insertWord(contentObject, object.getString("wordHead"));
            }
        } catch (IOException ignore) {
        }
    }

    private Word insertWord(JSONObject object, String wordHead) {
        Word word = new Word();
        word.setWordHead(wordHead);
        word.setUsPhone(object.getString("usphone"));
        word.setUkPhone(object.getString("ukphone"));
        word.setUsSpeech(object.getString("usspeech"));
        // 下载音标文件，存储到oss中
        // url = https://dict.youdao.com/dictvoice?audio=sensible&type=1  mp3file
        word.setUkSpeech(object.getString("ukspeech"));
        word.setPhone(object.getString("phone"));
        word.setPhone(object.getString("speech"));
        JSONObject remMethod = object.getJSONObject("remMethod");
        Assert.notNull(remMethod);
        word.setRemMethod(remMethod.getString("val"));
        wordService.save(word);
        return word;
    }
}
