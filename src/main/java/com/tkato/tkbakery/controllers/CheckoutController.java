package com.tkato.tkbakery.controllers;

import javax.servlet.http.HttpServletResponse;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class CheckoutController {

    @GetMapping("/checkout")
    public String checkout(Model model) {
        model.addAttribute("name", "test");
        return "checkout";
    }

    @GetMapping("/success")
    public String success(Model model) {
        return "success";
    }

    @GetMapping("/cancel")
    public String cance(Model model) {
        return "cancel";
    }

    @PostMapping("/createsession")
    public void createCheckoutSession(HttpServletResponse response) throws StripeException {
        Stripe.apiKey = System.getenv("STRIPE_SECRET_KEY");
        String domain = "http://localhost:8080/api/checkout";
        SessionCreateParams params = 
            SessionCreateParams.builder()
                .setMode(SessionCreateParams.Mode.PAYMENT)
                .setSuccessUrl(domain + "/success")
                .setCancelUrl(domain + "/cancel")
                .addLineItem(
                    SessionCreateParams.LineItem.builder()
                        .setQuantity(1L)
                        .setPrice("price_1KF5vkHEUlhmshphww8mvgRV")
                        .build()
                ).build();

        Session session = Session.create(params);
        response.setHeader("Location", session.getUrl());
        response.setStatus(302);
    }
}