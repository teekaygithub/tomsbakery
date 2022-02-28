package com.tkato.tkbakery.controllers;

import com.tkato.tkbakery.models.CustomProduct;
import com.tkato.tkbakery.services.ProductService;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private ProductService service;

    public HomeController(ProductService service) {
        this.service = service;
    }

    @GetMapping("/")
    public String home(Model model) {
        Page<CustomProduct> featured = service.findTop3();
        model.addAttribute("featured", featured);
        return "index";
    }
}
