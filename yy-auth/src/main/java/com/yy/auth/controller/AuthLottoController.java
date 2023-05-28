package com.yy.auth.controller;

import com.alibaba.nacos.common.utils.ThreadFactoryBuilder;
import com.yy.auth.entity.AuthLotto;
import com.yy.auth.service.AuthLottoService;
import com.yy.common.core.domain.R;
import com.yy.common.core.exception.ServiceException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @author sunruiguang
 * @date 2023-05-26
 */
@RestController
@RequestMapping("/lotto")
@Slf4j
public class AuthLottoController {

    private final AuthLottoService authLottoService;

    private final ExecutorService es = new ThreadPoolExecutor(3, 10, 60L,
            TimeUnit.SECONDS, new LinkedBlockingDeque<>(), new ThreadFactoryBuilder().build());

    public AuthLottoController(AuthLottoService authLottoService) {
        this.authLottoService = authLottoService;
    }

    @GetMapping("/generate")
    public R<?> generate(@RequestParam("pour") Integer pour) {
        ServiceException.isTrue(Objects.isNull(pour) || pour > 200000000, "数字过大");
        int a = pour / 10;
        if (a > 0) {
            for (int b = 0; b < 10; b++) {
                es.submit(() -> {
                    // 每个线程处理2000万条数据
                    for (int i = 0; i < a; i++) {
                        List<AuthLotto> authLottos = new ArrayList<>();
                        for (int j = 0; j < 1000; j++) {
                            List<Integer> list = new ArrayList<>();
                            randomNumber(list, 6, 34);
                            Collections.sort(list);
                            randomNumber(list, 1, 17);
                            authLottos.add(new AuthLotto(list.stream().map(String::valueOf).collect(Collectors.joining(", "))));
                        }
                        authLottoService.saveBatch(authLottos);
                        log.info("插入完成1000条数据");
                    }
                    log.info("插入完成2000万条数据");
                });
            }
        }

        return R.ok();
    }

    /**
     * 向list里生成count个随机数，随机数的范围[start,end)
     */
    private void randomNumber(List<Integer> list, int count, int end) {
        Random r = new Random();
        int temp = 0;
        while (temp != count) {
            //生成1个start到end的随机数,不包括end
            int randomNumber = r.ints(1, 1, end).findFirst().getAsInt();
            if (!list.contains(randomNumber)) {
                list.add(randomNumber);
                temp++;
            }
        }
    }
}
