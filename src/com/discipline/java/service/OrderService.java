package com.discipline.java.service;

import com.discipline.java.bean.Order;
import java.sql.SQLException;
import java.util.List;

public interface OrderService {
    List<Order> getOrderList(int uid) throws SQLException;
    Order getOrder(String id) throws SQLException;
    int updateOrderStatus(String id,int status) throws SQLException;
    int insertOrder(Order order)throws SQLException;
    int updatePayTime(String id)throws SQLException;
}
