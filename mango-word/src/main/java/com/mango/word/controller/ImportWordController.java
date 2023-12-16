package com.mango.word.controller;

import com.mango.common.core.domain.R;
import com.mango.word.entity.WordBook;
import com.mango.word.util.ImportWordBook;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/import")
@RequiredArgsConstructor(onConstructor_ = {@Autowired})
public class ImportWordController {

    private final ImportWordBook importWordBook;


    @PostMapping("/word")
    public R<?> importWordJson(@RequestBody WordBook wordBook) {
        Thread thread = new Thread(() -> importWordBook.importBook(wordBook));
        thread.start();
        return R.ok();
    }
}
