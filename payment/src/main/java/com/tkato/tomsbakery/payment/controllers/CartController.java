package com.tkato.tomsbakery.payment.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CartController {
    
    @GetMapping("/cart")
    public String shoppingCartView(Model model) {
        return "cart";
    }
}
