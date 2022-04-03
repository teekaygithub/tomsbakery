package com.tkato.tkbakery.controllers;

import com.tkato.tkbakery.models.CustomProduct;
import com.tkato.tkbakery.services.ProductService;

import org.springframework.data.domain.Page;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
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
    public String home(Model model, @AuthenticationPrincipal OidcUser user) {
        Page<CustomProduct> featured = service.findTop3();
        model.addAttribute("featured", featured);
        if (user != null) {
            model.addAttribute("userName", user.getFullName());
        }
        return "index";
    }
}
