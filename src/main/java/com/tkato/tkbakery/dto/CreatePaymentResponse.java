package com.tkato.tkbakery.dto;

public class CreatePaymentResponse {
    
    private String clientSecret;

    public CreatePaymentResponse(String clientSecret) {
        this.setClientSecret(clientSecret);
    }

    public String getClientSecret() {
        return clientSecret;
    }

    public void setClientSecret(String clientSecret) {
        this.clientSecret = clientSecret;
    }
}
