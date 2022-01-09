package com.tkato.tkbakery.repositories;

import com.tkato.tkbakery.models.Cart;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepository extends CrudRepository<Cart, Long> {
    
}
