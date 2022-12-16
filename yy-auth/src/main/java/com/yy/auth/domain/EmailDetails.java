package com.yy.auth.domain;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author sunruiguang
 * @date 2022-12-15
 */
@Data
@NoArgsConstructor
public class EmailDetails {

    /**
     * 收件人
     */
    private String recipient;

    /**
     * 邮件内容
     */
    private String msgBody;

    /**
     * 标题
     */
    private String subject;

    /**
     * 附件
     */
    private String attachment;
}
