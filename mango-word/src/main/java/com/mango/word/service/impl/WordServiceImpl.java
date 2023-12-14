package com.mango.word.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mango.word.entity.Word;
import com.mango.word.service.WordService;
import com.mango.word.mapper.WordMapper;
import org.springframework.stereotype.Service;

/**
* @author boycott
* @description 针对表【word(单词)】的数据库操作Service实现
* @createDate 2023-12-14 18:08:23
*/
@Service
public class WordServiceImpl extends ServiceImpl<WordMapper, Word>
    implements WordService{

}




