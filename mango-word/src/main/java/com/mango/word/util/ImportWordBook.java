package com.mango.word.util;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.mango.word.entity.*;
import com.mango.word.service.*;
import io.jsonwebtoken.lang.Assert;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.io.*;
import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor(onConstructor_ = {@Autowired})
public class ImportWordBook {

    private final WordService wordService;
    private final WordBookService wordBookService;
    private final WordSentenceService wordSentenceService;
    private final WordSynonymsService wordSynonymsService;
    private final WordSynonymsWordService wordSynonymsWordService;
    private final WordPhraseService wordPhraseService;

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

                Word word = saveWord(contentObject, object.getString("wordHead"));
                saveWordSentence(contentObject, word);
                saveWordSynonyms(contentObject, word);

                saveWordPhrase(contentObject, word);
                saveWordSameRoot(contentObject, word);
            }
        } catch (IOException ignore) {
        }
    }

    private void saveWordSameRoot(JSONObject object, Word word) {
    }

    private void saveWordPhrase(JSONObject object, Word word) {
        JSONObject phrase = object.getJSONObject("phrase");
        Assert.notNull(phrase);
        JSONArray phrasees = phrase.getJSONArray("phrasees");
        Assert.notEmpty(phrasees);
        List<WordPhrase> collect = phrasees.stream().map(item -> {
            JSONObject jsonObject = JSONObject.parseObject(item.toString());
            return new WordPhrase(word.getId(), jsonObject.getString("pContent"), jsonObject.getString("pCn"));
        }).collect(Collectors.toList());
        wordPhraseService.saveBatch(collect);
    }

    private void saveWordSynonyms(JSONObject object, Word word) {
        JSONObject syno = object.getJSONObject("syno");
        Assert.notNull(syno);
        JSONArray synos = syno.getJSONArray("synos");
        Assert.notEmpty(synos);
        for (Object o : synos) {
            JSONObject jsonObject = JSONObject.parseObject(o.toString());
            WordSynonyms wordSynonyms = new WordSynonyms();
            wordSynonyms.setWordId(word.getId());
            wordSynonyms.setWordType(jsonObject.getString("pos"));
            wordSynonyms.setZhContent(jsonObject.getString("tran"));

            wordSynonymsService.save(wordSynonyms);

            // 插入关联的单词
            JSONArray hwds = jsonObject.getJSONArray("hwds");
            Assert.notEmpty(hwds);
            List<WordSynonymsWord> w = hwds.stream().map(item -> {
                JSONObject jsonObject1 = JSONObject.parseObject(item.toString());
                return new WordSynonymsWord(wordSynonyms.getId(), jsonObject1.getString("w"));
            }).collect(Collectors.toList());
            wordSynonymsWordService.saveBatch(w);
        }
    }

    private void saveWordSentence(JSONObject object, Word word) {
        JSONObject sentence = object.getJSONObject("sentence");
        Assert.notNull(sentence);

        JSONArray sentences = sentence.getJSONArray("sentences");
        Assert.notEmpty(sentences);
        List<WordSentence> collect = sentences.stream().map(item -> {
            JSONObject jsonObject = JSONObject.parseObject(item.toString());
            return new WordSentence(word.getId(), jsonObject.getString("sContent"), jsonObject.getString("sCn"));
        }).collect(Collectors.toList());
        wordSentenceService.saveBatch(collect);
    }

    private Word saveWord(JSONObject object, String wordHead) {
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
