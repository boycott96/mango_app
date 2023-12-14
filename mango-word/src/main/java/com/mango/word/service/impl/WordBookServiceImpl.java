package com.mango.word.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mango.word.entity.WordBook;
import com.mango.word.service.WordBookService;
import com.mango.word.mapper.WordBookMapper;
import org.springframework.stereotype.Service;

/**
* @author boycott
* @description 针对表【word_book(单词书籍)】的数据库操作Service实现
* @createDate 2023-12-14 18:08:23
*/
@Service
public class WordBookServiceImpl extends ServiceImpl<WordBookMapper, WordBook>
    implements WordBookService{

}




