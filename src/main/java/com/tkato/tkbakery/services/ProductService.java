package com.tkato.tkbakery.services;

import com.tkato.tkbakery.models.CustomProduct;
import com.tkato.tkbakery.repositories.ProductRepository;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.annotation.PostConstruct;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Product;

@Service
public class ProductService {
    
    private final ProductRepository productRepository;
    
    @Value("${stripe.secret.key}")
    private String stripeSecretKey;

    private RestTemplate restTemplate;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
        this.restTemplate = new RestTemplate();
    }

    @PostConstruct
    public void init() {
        Stripe.apiKey = stripeSecretKey;
    }

    public Product findByProductId(String id) throws StripeException {
        Product product = Product.retrieve(id);
        return product;
    }

    public CustomProduct registerNewProduct(String name) {
        CustomProduct product = new CustomProduct();
        product.setName(name);
        return productRepository.save(product);
    }
}
