package com.discipline.java.dao;

import com.discipline.java.bean.Order;
import java.sql.SQLException;
import java.util.List;

public interface OrderDao {
    List<Order> getOrderList(int uid) throws SQLException;
    Order getOrder(String id) throws SQLException;
    int updateOrderStatus(String id,int status) throws SQLException;
    int insertOrder(Order order) throws SQLException;
    int updatePayTime(String id)throws SQLException;

    //获取当日、周、月、年订单成交额
    Double getTodaySales() throws SQLException;
    Double getWeekSales() throws SQLException;
    Double getMonthSales() throws SQLException;
    Double getYearSales() throws SQLException;

    //根据日期获取订单成交额
    Double getSalesByDate(String date)throws  SQLException;

    Long getTodayOrderNum()throws SQLException;
    Long getToDeliverOrderNum()throws SQLException;





}
