package com.tkato.tkbakery.repositories;

import java.util.List;

import com.tkato.tkbakery.models.CustomProduct;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends CrudRepository<CustomProduct, Long> {
    
    public CustomProduct findByCustomKey(String customKey);

    public void deleteByCustomKey(String customKey);

    public Page<CustomProduct> findAll(Pageable pageable);
}
