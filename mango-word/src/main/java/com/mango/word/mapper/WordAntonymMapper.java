package com.mango.word.mapper;

import com.mango.word.entity.WordAntonym;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
* @author admin
* @description 针对表【word_antonym(反义词)】的数据库操作Mapper
* @createDate 2023-12-16 17:25:19
* @Entity com.mango.word.entity.WordAntonym
*/
@Mapper
public interface WordAntonymMapper extends BaseMapper<WordAntonym> {

}




