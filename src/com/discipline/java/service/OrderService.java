package com.discipline.java.service;

import com.discipline.java.bean.Order;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface OrderService {
    List<Order> getOrderList(int uid) throws SQLException;
    Order getOrder(String id) throws SQLException;
    int updateOrderStatus(String id,int status) throws SQLException;
    int insertOrder(Order order)throws SQLException;
    int updatePayTime(String id)throws SQLException;

    Map<String,Double>getSales()throws SQLException;

    //今日新增订单数
    Long getTodayOrderNum()throws SQLException;
    //待发货订单数
    Long getToDeliverOrderNum()throws SQLException;

    //获取过去7天订单成交额
    Map<String,Double> getPast7DaysSales()throws SQLException;
}
