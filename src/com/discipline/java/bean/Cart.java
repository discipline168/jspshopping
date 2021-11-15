package com.discipline.java.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cart {
    private int id;
    private int gid;
    private int uid;
    private Goods goods;
    private int quantity;
    private String size;
}
