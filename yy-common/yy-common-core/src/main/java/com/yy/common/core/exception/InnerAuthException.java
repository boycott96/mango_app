package com.yy.common.core.exception;

import java.io.Serial;

/**
 * 内部认证异常
 *
 * @author yeyang
 */
public class InnerAuthException extends RuntimeException {
    @Serial
    private static final long serialVersionUID = 1L;

    public InnerAuthException(String message) {
        super(message);
    }
}
