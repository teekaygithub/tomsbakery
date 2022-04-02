package com.tkato.tkbakery.repositories;

import com.tkato.tkbakery.models.Customer;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerRepository extends CrudRepository<Customer, Long> {
    
}
