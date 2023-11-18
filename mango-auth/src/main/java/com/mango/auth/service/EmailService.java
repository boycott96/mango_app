package com.mango.auth.service;

import com.mango.auth.entity.EmailDetails;

import java.util.Map;

public interface EmailService {

    /**
     * 此方法可用于向所需收件人发送简单的文本电子邮件。
     *
     * @param details 邮件参数
     */
    void sendSimpleMail(EmailDetails details);

    /**
     * 此方法可用于将电子邮件连同附件一起发送给所需的收件人。
     *
     * @param details 邮件参数
     */
    void sendMailWithAttachment(EmailDetails details);

    /**
     * 获取注入到模板数据的html内容
     *
     * @param model 注入参数
     * @return messageBody
     */
    String getContentFromTemplate(Map<String, Object> model);
}
