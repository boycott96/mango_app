package com.mango.word.mapper;

import com.mango.word.entity.ExamChoice;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
* @author boycott
* @description 针对表【exam_choice(考题选择项)】的数据库操作Mapper
* @createDate 2023-12-14 18:08:23
* @Entity com.mango.word.entity.ExamChoice
*/
@Mapper
public interface ExamChoiceMapper extends BaseMapper<ExamChoice> {

}




