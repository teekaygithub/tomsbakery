package com.tkato.tkbakery.controllers;

import com.stripe.exception.StripeException;
import com.stripe.model.Product;
import com.tkato.tkbakery.services.ProductService;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/api/product")
public class ProductController {

    private ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }
    
    // @PostMapping("/register")
    // public ResponseEntity<?> registerProductRoute() {}

    @GetMapping("/")
    public ResponseEntity<String> getProductById(@RequestParam String productId) throws StripeException {
        productId = "prod_Kuc3TEyuE7iytK";
        Product product = productService.findByProductId(productId);
        return new ResponseEntity<String>(product.getName(), HttpStatus.OK);
    }
}
