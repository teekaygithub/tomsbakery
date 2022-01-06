package com.tkato.tkbakery.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CheckoutController {

    @GetMapping("/checkout")
    public String checkout(Model model) {
        model.addAttribute("name", "test");
        return "checkout";
    }
}