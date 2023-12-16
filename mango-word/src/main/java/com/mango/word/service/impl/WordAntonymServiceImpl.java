package com.mango.word.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mango.word.entity.WordAntonym;
import com.mango.word.service.WordAntonymService;
import com.mango.word.mapper.WordAntonymMapper;
import org.springframework.stereotype.Service;

/**
* @author admin
* @description 针对表【word_antonym(反义词)】的数据库操作Service实现
* @createDate 2023-12-16 17:25:19
*/
@Service
public class WordAntonymServiceImpl extends ServiceImpl<WordAntonymMapper, WordAntonym>
    implements WordAntonymService{

}




