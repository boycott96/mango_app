package com.mango.word.mapper;

import com.mango.word.entity.WordSynonymsWord;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
* @author boycott
* @description 针对表【word_synonyms_word(近义词)】的数据库操作Mapper
* @createDate 2023-12-14 18:08:23
* @Entity com.mango.word.entity.WordSynonymsWord
*/
@Mapper
public interface WordSynonymsWordMapper extends BaseMapper<WordSynonymsWord> {

}




