package com.yy.auth.service.impl;

import com.yy.auth.domain.EmailDetails;
import com.yy.auth.service.EmailService;
import com.yy.common.core.exception.ServiceException;
import com.yy.common.core.utils.StringUtils;
import freemarker.template.Configuration;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.File;
import java.util.Map;
import java.util.Objects;

/**
 * @author sunruiguang
 * @date 2022-12-15
 */
@Service
@Slf4j
public class EmailServiceImpl implements EmailService {

    @Resource
    private JavaMailSender javaMailSender;

    @Resource
    private Configuration configuration;

    // 发件人
    @Value("${spring.mail.username}")
    private String sender;

    @Override
    public void sendSimpleMail(EmailDetails details) {
        try {
            SimpleMailMessage mailMessage = new SimpleMailMessage();
            mailMessage.setFrom(sender);
            mailMessage.setTo(details.getRecipient());
            mailMessage.setText(details.getMsgBody());
            mailMessage.setSubject(details.getSubject());

            // sending the email;
            javaMailSender.send(mailMessage);
            log.info("邮件发送成功...");
        } catch (Exception e) {
            log.error("邮件发送失败..., {}", e.getMessage());
        }
    }

    @Override
    public void sendMailWithAttachment(EmailDetails details) {
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        MimeMessageHelper mimeMessageHelper;
        try {
            mimeMessageHelper = new MimeMessageHelper(mimeMessage, true);
            mimeMessageHelper.setFrom(sender);
            mimeMessageHelper.setTo(details.getRecipient());
            mimeMessageHelper.setText(details.getMsgBody(), true);
            mimeMessageHelper.setSubject(details.getSubject());

            // adding the attachment
            if (StringUtils.isNotEmpty(details.getAttachment())) {
                FileSystemResource file = new FileSystemResource(new File(details.getAttachment()));
                mimeMessageHelper.addAttachment(Objects.requireNonNull(file.getFilename()), file);
            }

            // sending
            javaMailSender.send(mimeMessage);
            log.info("邮件发送成功...");
        } catch (MessagingException e) {
            log.error("邮件发送失败..., {}", e.getMessage());
        }
    }

    @Override
    public String getContentFromTemplate(Map<String, Object> model) {
        StringBuilder content = new StringBuilder();
        try {
            content.append(FreeMarkerTemplateUtils.processTemplateIntoString(configuration.getTemplate("email-template.ftl"), model));
        } catch (Exception e) {
            log.error("获取邮件模版失败..., {}", e.getMessage());
            throw new ServiceException("获取邮件模版失败");
        }
        return content.toString();
    }
}
