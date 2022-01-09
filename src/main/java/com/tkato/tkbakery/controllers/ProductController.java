package com.tkato.tkbakery.controllers;

import javax.validation.Valid;

import com.stripe.exception.StripeException;
import com.stripe.model.Product;
import com.tkato.tkbakery.models.CustomProduct;
import com.tkato.tkbakery.services.ProductService;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/api/product")
public class ProductController {

    private ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }
    
    @PostMapping("/register")
    public ResponseEntity<CustomProduct> registerProductRoute(@Valid @RequestBody CustomProduct customProduct) throws StripeException {
        CustomProduct newProduct = productService.registerNewProduct(customProduct);
        return new ResponseEntity<CustomProduct>(newProduct, HttpStatus.CREATED);
    }

    @GetMapping("/")
    public ResponseEntity<CustomProduct> getProductById(@RequestParam String productId) throws StripeException {
        CustomProduct product = productService.findByProductId(productId);
        return new ResponseEntity<CustomProduct>(product, HttpStatus.OK);
    }

    // UPDATE a single product

    @DeleteMapping("/unregister")
    public ResponseEntity<String> removeProduct(@RequestParam String productId) throws StripeException {
        productService.removeByProductId(productId);
        return new ResponseEntity<String>(String.format("%s has been successfully removed.", productId), HttpStatus.OK);
    }
}
