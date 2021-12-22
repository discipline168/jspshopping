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


    // 创建资源
    private    Object resourceA = new Object();
    private   Object resourceB = new Object();

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

    @org.junit.Test
    public void sych() throws SQLException, InterruptedException {

        // 创建线程
        Thread threadA = new Thread(new Runnable() {
            public void run() {
                try {
                    // 获取resourceA共享资源的监视器锁
                    synchronized (orderService) {
                        System.out.println("threadA get orderService lock");

                        Thread.sleep(2000);
                    }
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });
        // 创建线程
        Thread threadB = new Thread(new Runnable() {
            public void run() {
                try {
                    //休眠1s
                    Thread.sleep(1000);
                    System.out.println("threadB try to get orderService lock------");
                    // 获取resourceA共享资源的监视器锁
                    synchronized (orderService) {
                        System.out.println("threadB get orderService lock");

                    }
                } catch (InterruptedException  e) {
                    e.printStackTrace();
                }
            }
        });
        // 启动线程
        threadA.start();
        threadB.start();
        // 等待两个线程结束
        threadA.join();
        threadB.join();
        System.out.println("main over");

    }
}
