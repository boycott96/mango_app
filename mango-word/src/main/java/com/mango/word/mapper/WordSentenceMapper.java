package com.mango.word.mapper;

import com.mango.word.entity.WordSentence;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
* @author boycott
* @description 针对表【word_sentence(句子)】的数据库操作Mapper
* @createDate 2023-12-14 18:08:23
* @Entity com.mango.word.entity.WordSentence
*/
@Mapper
public interface WordSentenceMapper extends BaseMapper<WordSentence> {

}




