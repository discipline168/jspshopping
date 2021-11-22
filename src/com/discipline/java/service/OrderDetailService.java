package com.discipline.java.service;

import com.discipline.java.bean.Cart;
import com.discipline.java.bean.OrderDetail;
import java.sql.SQLException;
import java.util.List;

public interface OrderDetailService {
    List<OrderDetail> getOrderDetailList(String oid) throws SQLException;
    int insertOrderDetails(List<Cart> cartList,String oid) throws SQLException;
}
