package com.discipline.java.dao;

import com.discipline.java.bean.OrderDetail;
import java.sql.SQLException;
import java.util.List;

public interface OrderDetailDao {
    List<OrderDetail> getOrderDetailList(String oid) throws SQLException;
    int insertOrderDetail(OrderDetail orderDetail)throws SQLException;
}
