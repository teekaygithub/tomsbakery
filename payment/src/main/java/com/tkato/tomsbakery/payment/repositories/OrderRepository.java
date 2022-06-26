package com.tkato.tomsbakery.payment.repositories;

import com.tkato.tomsbakery.payment.models.Order;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends CrudRepository<Order, Long> {
    
}
