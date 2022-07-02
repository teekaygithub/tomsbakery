package com.tkato.tomsbakery.common;

import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class OrderDetails {

    private Long id;
    private String email;
    private String trackingNumber;
    private BigDecimal totalPrice;
    private LocalDateTime createdDate;
}
