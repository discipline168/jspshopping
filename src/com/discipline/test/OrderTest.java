package com.discipline.test;


import com.discipline.java.bean.Order;
import java.util.concurrent.DelayQueue;
import java.util.concurrent.TimeUnit;

public class OrderTest {
    private DelayQueue<Order> delayQueue=new DelayQueue<>();

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
}
