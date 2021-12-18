package com.discipline.test;


import com.discipline.java.bean.Order;
import com.discipline.java.dao.OrderDao;
import com.discipline.java.dao.impl.OrderDaoImpl;
import com.discipline.java.service.OrderService;
import com.discipline.java.service.impl.OrderServiceImpl;
import com.discipline.java.utils.OrderUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.concurrent.DelayQueue;
import java.util.concurrent.TimeUnit;

public class OrderTest {
    private DelayQueue<Order> delayQueue=new DelayQueue<>();
    private OrderService orderService=new OrderServiceImpl();
    private OrderDao orderDao=new OrderDaoImpl();

    @org.junit.Test
    public void overdue() throws InterruptedException {
        new Thread(()->{
            Order order = new Order();
            order.setDelay(5000);
            order.setId("a");
            delayQueue.put(order);
        },"a").run();



        new Thread(()->{
            try{ TimeUnit.SECONDS.sleep(3); }catch (InterruptedException e) {e.printStackTrace();}
            Order order = new Order();
            order.setDelay(5000);
            order.setId("b");
            delayQueue.put(order);
        },"b").run();
        while (delayQueue.size()>0){
            Order take = delayQueue.take();
            System.out.println(take.getId()+"已逾期");
        }

    }

    @org.junit.Test
    public void getPast7Days() throws SQLException {
        /*ArrayList<String> days = OrderUtils.getPast7Days();
        System.out.println(days);*/
        System.out.println(orderService.getPast7DaysSales());
        //System.out.println(orderService.getSales());
        //System.out.println(orderDao.getSalesByDate("2021-12-17"));
    }
}
