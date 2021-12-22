package com.discipline.java.service;

import com.discipline.java.bean.Order;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface OrderService {
    //根据用户id获取其订单信息
    List<Order> getOrderList(int uid) throws SQLException;

    //分页获取所有订单信息[admin]
    List<Order> getAllOrderListByPage(int page, int size, int status) throws SQLException;

    Order getOrder(String id) throws SQLException;
    int updateOrderStatus(String id,int status) throws SQLException;
    int insertOrder(Order order)throws SQLException;
    int updatePayTime(String id)throws SQLException;

    //获取当日、周、月、年订单成交额[admin]
    Map<String,BigDecimal>getSales()throws SQLException;

    //获取当天新增订单数[admin]
    Long getTodayOrderNum()throws SQLException;
    //获取待发货订单数[admin]
    Long getToDeliverOrderNum()throws SQLException;

    //获取过去7天订单成交额[admin]
    Map<String, BigDecimal> getPast7DaysSales()throws SQLException;
    //发货[admin]
    int deliver(String oid,String lid)throws SQLException;
    //获取所有订单总数[admin]
    long getAllOrderSum(int status)throws SQLException;


}
