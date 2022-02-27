package com.tkato.tkbakery.controllers;

import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;
import com.tkato.tkbakery.dto.CheckoutData;
import com.tkato.tkbakery.dto.CreatePaymentResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CheckoutRestController {

    private Logger logger = LoggerFactory.getLogger(CheckoutRestController.class);
    
    // TODO: Add exception handling for StripeException
    @PostMapping("/api/payment-intent")
    public ResponseEntity<CreatePaymentResponse> createPaymentIntent(@RequestBody CheckoutData checkoutData) throws StripeException {
        logger.info(
            String.format("Customer name: %s, email: %s, phone: %s", 
                checkoutData.getName(),
                checkoutData.getEmail(),
                checkoutData.getPhoneNumber()
                ));
        PaymentIntentCreateParams params = new PaymentIntentCreateParams.Builder()
            .setCurrency("usd")
            .setAmount(4200L )
            .build();

        PaymentIntent intent = PaymentIntent.create(params);

        CreatePaymentResponse res = new CreatePaymentResponse(intent.getClientSecret());
        return new ResponseEntity<CreatePaymentResponse>(res, HttpStatus.OK);
    }
}
