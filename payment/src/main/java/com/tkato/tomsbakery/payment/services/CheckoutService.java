package com.tkato.tomsbakery.payment.services;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Set;
import java.util.UUID;

import com.tkato.tomsbakery.common.OrderDetails;
import com.tkato.tomsbakery.payment.dto.CheckoutData;
import com.tkato.tomsbakery.payment.models.Customer;
import com.tkato.tomsbakery.payment.models.Order;
import com.tkato.tomsbakery.payment.models.OrderItem;
import com.tkato.tomsbakery.payment.repositories.CustomerRepository;

import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class CheckoutService {
    
    private final CustomerRepository repo;

    private final KafkaTemplate<String, OrderDetails> kafkaTemplate;

    public CheckoutService (
            CustomerRepository repo,
            KafkaTemplate<String, OrderDetails> kafkaTemplate) {
        this.repo = repo;
        this.kafkaTemplate = kafkaTemplate;
    }

    public String orderComplete(CheckoutData checkoutData) {
        String orderId = UUID.randomUUID().toString();

        // Create new order object
        Order order = new Order();
        order.setTrackingNumber(orderId);
        order.setTotalPrice(new BigDecimal(checkoutData.getSubTotal()));

        // Convert each order item to entity object and link with order object
        // TODO: Validate order items:
        // - Does item exist?
        // - Is the unit price correct?
        Set<OrderItem> orderItems = checkoutData.getOrderItems();
        orderItems.forEach((item) -> order.add(item));

        // Create new customer object
        Customer existing = repo.findByEmail(checkoutData.getEmail());

        if (existing != null) {
            existing.add(order);
            repo.save(existing);
        } else {
            Customer customer = new Customer();
            customer.setName(checkoutData.getName());
            customer.setEmail(checkoutData.getEmail());
            customer.setPhoneNumber(checkoutData.getPhoneNumber());
            customer.add(order);
            repo.save(customer);
        }

        OrderDetails orderDetails = OrderDetails.builder()
                .id(order.getId())
                .trackingNumber(order.getTrackingNumber())
                .totalPrice(order.getTotalPrice())
                .createdDate(LocalDateTime.now())
                .build();

        log.info("Sending order details, ID: {}, total price: {}",
                orderDetails.getId(),
                orderDetails.getTotalPrice());
        kafkaTemplate.send("orders", orderDetails);

        return orderId;
    }
}
