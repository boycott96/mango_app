package com.mango.word.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mango.word.entity.WordPhrase;
import com.mango.word.service.WordPhraseService;
import com.mango.word.mapper.WordPhraseMapper;
import org.springframework.stereotype.Service;

/**
* @author boycott
* @description 针对表【word_phrase(常用短语)】的数据库操作Service实现
* @createDate 2023-12-14 18:08:23
*/
@Service
public class WordPhraseServiceImpl extends ServiceImpl<WordPhraseMapper, WordPhrase>
    implements WordPhraseService{

}




