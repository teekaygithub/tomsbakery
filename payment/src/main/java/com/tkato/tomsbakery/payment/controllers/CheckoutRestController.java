package com.tkato.tomsbakery.payment.controllers;

import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;
import com.tkato.tomsbakery.payment.dto.CheckoutData;
import com.tkato.tomsbakery.payment.dto.CreatePaymentResponse;
import com.tkato.tomsbakery.payment.services.CheckoutService;

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

    private CheckoutService service;

    public CheckoutRestController(CheckoutService service) {
        this.service = service;
    }
    
    // TODO: Add exception handling for StripeException
    @PostMapping("/api/payment-intent")
    public ResponseEntity<CreatePaymentResponse> createPaymentIntent(@RequestBody CheckoutData checkoutData) throws StripeException {
        logger.info(
            String.format("Customer name: %s, email: %s, phone: %s, subtotal: %d", 
                checkoutData.getName(),
                checkoutData.getEmail(),
                checkoutData.getPhoneNumber(),
                checkoutData.getSubTotal()
                ));
        PaymentIntentCreateParams params = new PaymentIntentCreateParams.Builder()
            .setCurrency("usd")
            .setAmount(checkoutData.getSubTotal())
            .build();

        PaymentIntent intent = PaymentIntent.create(params);

        CreatePaymentResponse res = new CreatePaymentResponse(intent.getClientSecret());
        return new ResponseEntity<CreatePaymentResponse>(res, HttpStatus.OK);
    }

    @PostMapping("/orderComplete")
    public ResponseEntity<String> orderComplete(
        @RequestBody CheckoutData checkoutData) {
        logger.info(checkoutData.toString());

        String orderId = service.orderComplete(checkoutData);

        return new ResponseEntity<String>(String.format("order completed successfully, order ID: %s", orderId), HttpStatus.OK);
    }
}
