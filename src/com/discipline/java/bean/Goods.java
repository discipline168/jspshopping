package com.discipline.java.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Goods {

    private int id;
    private String  name;
    private double  price;
    private int quantity;
    private double  discount;
    private String  picture;
    private String  description;
    private int categoryid;
    private Category category;
    private int sale;
    private String  others;
    private String sizes;
    private int status;

}
