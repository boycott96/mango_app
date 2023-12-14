package com.mango.word.mapper;

import com.mango.word.entity.Word;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
* @author boycott
* @description 针对表【word(单词)】的数据库操作Mapper
* @createDate 2023-12-14 18:08:23
* @Entity com.mango.word.entity.Word
*/
@Mapper
public interface WordMapper extends BaseMapper<Word> {

}




