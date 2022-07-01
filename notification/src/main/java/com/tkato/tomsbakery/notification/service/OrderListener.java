package com.tkato.tomsbakery.notification.service;

import com.tkato.tomsbakery.common.OrderDetails;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class OrderListener {

    @KafkaListener(
            topics = "orders",
            groupId = "com.tkato.tomsbakery"
    )
    public void listen(OrderDetails order) {
        log.info("Order received: tracking number: {}, total price: {}",
                order.getTrackingNumber(),
                order.getTotalPrice());

        // TODO: send notification via email
    }
}
