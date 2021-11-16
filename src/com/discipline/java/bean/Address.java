package com.discipline.java.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Address {
    private int id;
    private String region;
    private String detail;
    private int uid;
    private String name;
    private String phone;
    private int level;
}
