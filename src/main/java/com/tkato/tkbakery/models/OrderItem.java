package com.tkato.tkbakery.models;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="order_item")
public class OrderItem {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="unit_price")
    private BigDecimal unitPrice;

    @Column(name="quantity")
    private Integer quantity;

    @OneToOne
    private CustomProduct product;

    @ManyToOne
    @JoinColumn(name="order_id")
    private Order order;
}
