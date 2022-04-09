package com.tkato.tkbakery.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CheckoutController {

    private Logger logger = LoggerFactory.getLogger(CheckoutController.class);

    @GetMapping("/checkout")
    public String checkout(Model model, @AuthenticationPrincipal OidcUser user) {
        if (user != null) {
            model.addAttribute("name", user.getFullName());
            model.addAttribute("email", user.getEmail());
            model.addAttribute("phone", user.getPhoneNumber());
            logger.info(String.format("User attributes: %s", user.getAttributes().toString()));
        } else {
            model.addAttribute("name", "");
            model.addAttribute("email", "");
            model.addAttribute("phone", "");
        }
        return "checkout";
    }

    @GetMapping("/success")
    public String success() {
        return "success";
    }
}