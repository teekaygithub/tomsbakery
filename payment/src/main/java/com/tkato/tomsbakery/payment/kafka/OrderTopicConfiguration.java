package com.tkato.tomsbakery.payment.kafka;

import org.apache.kafka.clients.admin.NewTopic;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.config.TopicBuilder;

@Configuration
public class OrderTopicConfiguration {

    @Bean
    public NewTopic orderTopic() {
        return TopicBuilder
                .name("orders")
                .build();
    }
}
