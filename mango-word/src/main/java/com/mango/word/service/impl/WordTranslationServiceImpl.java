package com.mango.word.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mango.word.entity.WordTranslation;
import com.mango.word.service.WordTranslationService;
import com.mango.word.mapper.WordTranslationMapper;
import org.springframework.stereotype.Service;

/**
* @author boycott
* @description 针对表【word_translation(单词翻译信息)】的数据库操作Service实现
* @createDate 2023-12-14 18:08:23
*/
@Service
public class WordTranslationServiceImpl extends ServiceImpl<WordTranslationMapper, WordTranslation>
    implements WordTranslationService{

}




