package com.tkato.tkbakery.services;

import com.tkato.tkbakery.models.CustomProduct;
import com.tkato.tkbakery.repositories.ProductRepository;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.transaction.Transactional;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Price;
import com.stripe.model.Product;

@Service
public class ProductService {
    
    private final ProductRepository productRepository;
    
    @Value("${stripe.secret.key}")
    private String stripeSecretKey;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @PostConstruct
    public void init() {
        Stripe.apiKey = stripeSecretKey;
    }

    public CustomProduct registerNewProduct(CustomProduct newProduct) throws StripeException {
        // First register the product with Stripe
        Map<String, Object> params = new HashMap<>();
        params.put("name", newProduct.getName());
        Product product = Product.create(params);

        // Second, register a price object with the newly created product
        Map<String, Object> priceparams = new HashMap<>();
        priceparams.put("currency", "usd");
        priceparams.put("unit_amount", newProduct.getPrice());
        priceparams.put("product", product.getId());
        Price price = Price.create(priceparams);

        // Now save in our DB. Be sure to set Stripe's unique ID for the product onto our copy as well.
        newProduct.setCustomKey(product.getId());
        return productRepository.save(newProduct);
    }

    public CustomProduct findByProductId(String id) throws StripeException {
        Product product = Product.retrieve(id);
        return productRepository.findByCustomKey(product.getId());
    }

    @Transactional
    public void removeByProductId(String id) throws StripeException {
        // Stripe API does not support deletion of a product if there is a price-object associated
        // with it. Therefore all we can do is to deactivate the product and manually delete each product-price price pair
        // over the Stripe dashboard.
        Product product = Product.retrieve(id);
        Map<String, Object> params = new HashMap<>();
        params.put("active", false);
        Product updatedProduct = product.update(params);

        productRepository.deleteByCustomKey(id);
    }
}
