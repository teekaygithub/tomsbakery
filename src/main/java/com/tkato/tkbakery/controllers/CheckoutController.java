package com.tkato.tkbakery.controllers;

import com.tkato.tkbakery.dto.CheckoutData;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class CheckoutController {

    private Logger logger = LoggerFactory.getLogger(CheckoutController.class);

    @GetMapping("/checkout")
    public String checkout(Model model) {
        model.addAttribute("name", "test");
        return "checkout";
    }

    @GetMapping("/success")
    public String success() {
        return "success";
    }
}