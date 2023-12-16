package com.mango.word.util;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.mango.word.entity.*;
import com.mango.word.service.*;
import io.jsonwebtoken.lang.Assert;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor(onConstructor_ = {@Autowired})
public class ImportWordBook {

    private final WordService wordService;
    private final WordBookService wordBookService;
    private final WordSentenceService wordSentenceService;
    private final WordSynonymsService wordSynonymsService;
    private final WordSynonymsWordService wordSynonymsWordService;
    private final WordPhraseService wordPhraseService;
    private final WordSameRootService wordSameRootService;
    private final WordTranslationService wordTranslationService;
    private final WordAntonymService wordAntonymService;

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

    public String getLastProperties(WordBook wordBook) {
        int size = 0;
        String res = null;
        try (BufferedReader br = new BufferedReader(new FileReader(wordBook.getOriginUrl()))) {
            String line;
            while ((line = br.readLine()) != null) {
                JSONObject object = JSONObject.parse(line);
                JSONObject content = object.getJSONObject("content");
                JSONObject wordObject = content.getJSONObject("word");
                JSONObject contentObject = wordObject.getJSONObject("content");
                if (contentObject.size() > size) {
                    size = contentObject.size();
                    res = JSON.toJSONString(contentObject);
                }
            }
        } catch (IOException ignore) {
        }
        return res;
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

                Word word = saveWord(contentObject, object.getString("headWord"), wordBook.getId());
                saveWordSentence(contentObject, word);
                saveWordSynonyms(contentObject, word);
                saveWordAntonym(contentObject, word);

                saveWordPhrase(contentObject, word);
                saveWordSameRoot(contentObject, word);
                saveTranslation(contentObject, word);
            }
        } catch (IOException ignore) {
        }
    }

    private void saveWordAntonym(JSONObject object, Word word) {
        JSONObject antos = object.getJSONObject("antos");
        if (Objects.nonNull(antos)) {
            JSONArray anto = antos.getJSONArray("anto");
            List<WordAntonym> hwd = anto.stream().map(item -> {
                JSONObject jsonObject = JSONObject.parseObject(item.toString());
                return new WordAntonym(word.getId(), jsonObject.getString("hwd"));
            }).toList();
            wordAntonymService.saveBatch(hwd);
        }
    }

    private void saveTranslation(JSONObject object, Word word) {
        JSONArray trans = object.getJSONArray("trans");
        Assert.notNull(trans);
        List<WordTranslation> collect = trans.stream().map(item -> {
            JSONObject jsonObject = JSONObject.parseObject(item.toString());
            return new WordTranslation(word.getId(), jsonObject.getString("tranCn"), jsonObject.getString("pos")
                    , jsonObject.getString("tranOther"));
        }).toList();
        wordTranslationService.saveBatch(collect);
    }

    private void saveWordSameRoot(JSONObject object, Word word) {
        JSONObject relWord = object.getJSONObject("relWord");
        if (Objects.nonNull(relWord)) {
            JSONArray rels = relWord.getJSONArray("rels");
            List<WordSameRoot> collect = rels.stream().flatMap(item -> {
                JSONObject jsonObject = JSONObject.parseObject(item.toString());
                JSONArray words = jsonObject.getJSONArray("words");
                String pos = jsonObject.getString("pos");
                return words.stream().map(o -> {
                    JSONObject jsonObject1 = JSONObject.parseObject(o.toString());
                    return new WordSameRoot(word.getId(), pos, jsonObject1.getString("hwd"), jsonObject1.getString("tran"));
                });
            }).toList();
            wordSameRootService.saveBatch(collect);
        }
    }

    private void saveWordPhrase(JSONObject object, Word word) {
        JSONObject phrase = object.getJSONObject("phrase");
        if(Objects.nonNull(phrase)) {
            JSONArray phrases = phrase.getJSONArray("phrases");
            Assert.notEmpty(phrases);
            List<WordPhrase> collect = phrases.stream().map(item -> {
                JSONObject jsonObject = JSONObject.parseObject(item.toString());
                return new WordPhrase(word.getId(), jsonObject.getString("pContent"), jsonObject.getString("pCn"));
            }).collect(Collectors.toList());
            wordPhraseService.saveBatch(collect);
        }
    }

    private void saveWordSynonyms(JSONObject object, Word word) {
        JSONObject syno = object.getJSONObject("syno");
        if (Objects.nonNull(syno)) {
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
    }

    private void saveWordSentence(JSONObject object, Word word) {
        JSONObject sentence = object.getJSONObject("sentence");
        if (Objects.nonNull(sentence)) {
            JSONArray sentences = sentence.getJSONArray("sentences");
            Assert.notEmpty(sentences);
            List<WordSentence> collect = sentences.stream().map(item -> {
                JSONObject jsonObject = JSONObject.parseObject(item.toString());
                return new WordSentence(word.getId(), jsonObject.getString("sContent"), jsonObject.getString("sCn"));
            }).collect(Collectors.toList());
            wordSentenceService.saveBatch(collect);
        }
    }

    private Word saveWord(JSONObject object, String wordHead, Long bookId) {
        Word word = new Word();
        word.setWordHead(wordHead);
        word.setBookId(bookId);
        word.setUsPhone(object.getString("usphone"));
        word.setUkPhone(object.getString("ukphone"));
        word.setUsSpeech(object.getString("usspeech"));
        // 下载音标文件，存储到oss中
        // url = https://dict.youdao.com/dictvoice?audio=sensible&type=1  mp3file
        word.setUkSpeech(object.getString("ukspeech"));
        word.setPhone(object.getString("phone"));
        word.setPhone(object.getString("speech"));
        JSONObject remMethod = object.getJSONObject("remMethod");
        if (Objects.nonNull(remMethod)) {
            word.setRemMethod(remMethod.getString("val"));
        }
        wordService.save(word);
        return word;
    }
}
