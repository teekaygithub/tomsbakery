package com.tkato.tomsbakery.common;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Date;

@AllArgsConstructor
@Getter
@Setter
public class OrderDetails {

    private Long id;
    private String trackingNumber;
    private BigDecimal totalPrice;
    private Date createdDate;
}
