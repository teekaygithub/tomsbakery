package com.tkato.tomsbakery.notification.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class NotificationService {

    private final JavaMailSender javaMailSender;

    public NotificationService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    // Send receipt of order
    void sendEmail(String email, String orderId) {
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(email);
        msg.setSubject(orderId);
        msg.setText("Thank you for your order! Order ID: " + orderId);

        log.info("Sending notification email to {}", email);
        javaMailSender.send(msg);
    }
}
