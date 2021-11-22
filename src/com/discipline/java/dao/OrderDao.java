package com.discipline.java.dao;

import com.discipline.java.bean.Order;
import org.omg.CORBA.INTERNAL;

import java.sql.SQLException;
import java.util.List;

public interface OrderDao {
    List<Order> getOrderList(int uid) throws SQLException;
    Order getOrder(String id) throws SQLException;
    int updateOrderStatus(String id,int status) throws SQLException;
    int insertOrder(Order order) throws SQLException;
    int updatePayTime(String id)throws SQLException;
}
