package service;

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
    public void listen(String order) {
        log.info("Order received: {}", order);

        // TODO: save to db
    }
}
