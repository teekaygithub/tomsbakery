package com.tkato.tkbakery.repositories;

import com.tkato.tkbakery.models.User;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    
    public User findByEmail(String email);
}
