package com.tkato.tkbakery.services;

import java.math.BigDecimal;
import java.util.Set;
import java.util.UUID;

import com.tkato.tkbakery.dto.CheckoutData;
import com.tkato.tkbakery.models.Customer;
import com.tkato.tkbakery.models.Order;
import com.tkato.tkbakery.models.OrderItem;
import com.tkato.tkbakery.repositories.CustomerRepository;

import org.springframework.stereotype.Service;

@Service
public class CheckoutService {
    
    private CustomerRepository repo;

    public CheckoutService (CustomerRepository repo) {
        this.repo = repo;
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
        return orderId;
    }
}
