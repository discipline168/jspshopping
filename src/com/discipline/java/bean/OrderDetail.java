package com.discipline.java.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetail {
    private int id;
    private String oid;
    private int gid;
    private double price;
    private int quantity;
    private String size;
    private String name;
}
