package com.tkato.tomsbakery.dto;

import java.util.HashSet;
import java.util.Set;

import com.tkato.tomsbakery.models.OrderItem;

public class CheckoutData {
    
    private String name;
    
    private String email;
    
    private String phoneNumber;

    private Long subTotal;

    private Set<OrderItem> orderItems = new HashSet<>();

    public CheckoutData(String name, String email, String phoneNumber, Long subTotal) {
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.subTotal = subTotal;
    }

    public Long getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(Long subTotal) {
        this.subTotal = subTotal;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    @Override
    public String toString() {
        return String.format("CheckoutData email: %s, total: %s", email, subTotal.toString());
    }

    public Set<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(Set<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
}
