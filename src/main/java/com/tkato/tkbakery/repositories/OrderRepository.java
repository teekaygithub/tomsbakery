package com.tkato.tkbakery.repositories;

import com.tkato.tkbakery.models.Order;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends CrudRepository<Order, Long> {
    
}
