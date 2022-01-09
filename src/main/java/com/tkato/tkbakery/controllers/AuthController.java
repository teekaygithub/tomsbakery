package com.tkato.tkbakery.controllers;

import com.tkato.tkbakery.services.UserService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AuthController {

    private UserService userService;

    public AuthController (UserService userService) {
        this.userService = userService;
    }
    
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    // GET single registered user

    // GET all registered users

    // POST new user for registration

    // UPDATE user

    // DELETE user
}
