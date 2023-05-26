package com.yy.auth.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.auth.entity.AuthLotto;
import com.yy.auth.mapper.AuthLottoMapper;
import com.yy.auth.service.AuthLottoService;
import org.springframework.stereotype.Service;

/**
 * @author sunruiguang
 * @date 2023-05-26
 */
@Service
public class AuthLottoServiceImpl extends ServiceImpl<AuthLottoMapper, AuthLotto> implements AuthLottoService {
}
