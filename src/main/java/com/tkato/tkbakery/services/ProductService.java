package com.tkato.tkbakery.services;

import com.tkato.tkbakery.models.CustomProduct;
import com.tkato.tkbakery.repositories.ProductRepository;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.transaction.Transactional;

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

    public CustomProduct registerNewProduct(String name) throws StripeException {
        // First register the product with Stripe
        Map<String, Object> params = new HashMap<>();
        params.put("name", name);
        Product product = Product.create(params);

        // Now save in our DB. Be sure to set Stripe's unique ID for the product onto our copy as well.
        CustomProduct customProduct = new CustomProduct();
        customProduct.setName(name);
        customProduct.setCustomKey(product.getId());
        return productRepository.save(customProduct);
    }

    public CustomProduct findByProductId(String id) throws StripeException {
        Product product = Product.retrieve(id);
        return productRepository.findByCustomKey(product.getId());
    }

    @Transactional
    public void removeByProductId(String id) throws StripeException {
        Product product = Product.retrieve(id);
        Product deletedProduct = product.delete();

        productRepository.deleteByCustomKey(deletedProduct.getId());
    }
}