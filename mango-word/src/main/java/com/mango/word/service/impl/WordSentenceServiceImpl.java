package com.mango.word.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mango.word.entity.WordSentence;
import com.mango.word.service.WordSentenceService;
import com.mango.word.mapper.WordSentenceMapper;
import org.springframework.stereotype.Service;

/**
* @author boycott
* @description 针对表【word_sentence(句子)】的数据库操作Service实现
* @createDate 2023-12-14 18:08:23
*/
@Service
public class WordSentenceServiceImpl extends ServiceImpl<WordSentenceMapper, WordSentence>
    implements WordSentenceService{

}




