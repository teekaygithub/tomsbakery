package com.tkato.tomsbakery.repositories;

import com.tkato.tomsbakery.models.Customer;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerRepository extends CrudRepository<Customer, Long> {
    
    public Customer findByEmail(String email);
}
