package com.discipline.java.service.impl;

import com.discipline.java.bean.Order;
import com.discipline.java.dao.OrderDao;
import com.discipline.java.dao.impl.OrderDaoImpl;
import com.discipline.java.service.OrderService;
import com.discipline.java.utils.OrderUtils;

import java.sql.SQLException;
import java.util.List;

public class OrderServiceImpl implements OrderService {
    private OrderDao orderDao=new OrderDaoImpl();

    @Override
    public List<Order> getOrderList(int uid) throws SQLException {
        List<Order> orderList = orderDao.getOrderList(uid);
        for(Order order :orderList){
            //格式化时间字符串
            if(order.getOrderTime()!=null)
                order.setOtime(OrderUtils.transform(order.getOrderTime()));
            if(order.getPayTime()!=null)
                order.setPtime(OrderUtils.transform(order.getPayTime()));
        }
        return orderList;
    }

    @Override
    public Order getOrder(String id) throws SQLException {
        Order order = orderDao.getOrder(id);
        if(order!=null){
            //格式化时间字符串
            if(order.getOrderTime()!=null)
                order.setOtime(OrderUtils.transform(order.getOrderTime()));
            if(order.getPayTime()!=null)
                order.setPtime(OrderUtils.transform(order.getPayTime()));
        }

        return order;
    }

    @Override
    public int updateOrderStatus(String id, int status) throws SQLException {
        return orderDao.updateOrderStatus(id,status);
    }

    @Override
    public int insertOrder(Order order) throws SQLException {
        return orderDao.insertOrder(order);
    }

    @Override
    public int updatePayTime(String id) throws SQLException {
        return orderDao.updatePayTime(id);
    }
}
