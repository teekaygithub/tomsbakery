package com.tkato.tkbakery.dto;

public class CheckoutData {
    
    private String name;
    
    private String email;
    
    private String phoneNumber;

    private Long subTotal;

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
}
