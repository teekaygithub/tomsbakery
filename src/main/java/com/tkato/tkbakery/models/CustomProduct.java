package com.tkato.tkbakery.models;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
public class CustomProduct {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String customKey;

    private String customPriceKey;

    @NotEmpty(message = "Product name required")
    private String name;

    @NotNull(message = "Product price required in cents (USD)")
    // Price in US cents (e.g. 300 cents = $3.00)
    private Integer price;

    private String description;

    private boolean isActive = true;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createdAt;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date updatedAt;

    public Long getId() {
        return id;
    }

    public String getCustomPriceKey() {
        return customPriceKey;
    }

    public void setCustomPriceKey(String customPriceKey) {
        this.customPriceKey = customPriceKey;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public String getCustomKey() {
        return customKey;
    }

    public void setCustomKey(String customKey) {
        this.customKey = customKey;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }
}
