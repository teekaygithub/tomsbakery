package com.tkato.tomsbakery.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CheckoutController {

    private Logger logger = LoggerFactory.getLogger(CheckoutController.class);

    @GetMapping("/checkout")
    public String checkout(Model model) {
        return "checkout";
    }

    @GetMapping("/success")
    public String success() {
        return "success";
    }
}