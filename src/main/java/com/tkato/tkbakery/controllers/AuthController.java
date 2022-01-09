package com.tkato.tkbakery.controllers;

import java.util.List;

import javax.validation.Valid;

import com.tkato.tkbakery.models.User;
import com.tkato.tkbakery.services.UserService;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

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
    @GetMapping("/users/all")
    public ResponseEntity<List<User>> getAllUserRoute() {
        List<User> userList = userService.getAllUsers();
        return new ResponseEntity<List<User>>(userList, HttpStatus.OK);
    }

    // POST new user for registration
    @PostMapping("/users/register")
    public ResponseEntity<User> registerUserRoute(@Valid @RequestBody User user) {
        User newUser = userService.registerUser(user);
        return new ResponseEntity<User>(newUser, HttpStatus.CREATED);
    }

    // UPDATE user

    // DELETE user
}
