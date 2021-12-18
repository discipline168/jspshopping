package com.discipline.test;


import com.discipline.java.utils.QiniuCloudUtil;
import org.apache.commons.lang3.RandomStringUtils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;


public class UtilsTest {
    @org.junit.Test
    public void generateOrderId() {
        //时间（精确到毫秒）
        DateTimeFormatter ofPattern = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
        String localDate = LocalDateTime.now().format(ofPattern);
        //3位随机数
        String randomNumeric = RandomStringUtils.randomNumeric(3);

        String orderNum = localDate + randomNumeric;
        System.out.println(orderNum);
    }


    @org.junit.Test
    public void timetest(){

        System.out.println("11111");



        Object lock = new Object();
        Thread t = new Thread(() -> {
            try{ TimeUnit.SECONDS.sleep(3); }catch (InterruptedException e) {e.printStackTrace();}
            System.out.println("aaaaaa");

            synchronized (lock) {//获取对象锁
                lock.notify();//子线程唤醒
            }
        });

        //启动子线程
        t.start();
        try {
            synchronized (lock) {//这里也是一样
                lock.wait();//主线程等待
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }



}


    public void overdue (){

        Timer t = new Timer();
        t.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                System.out.println("hello world");
            }
        }, 5, 1);
    }

    @org.junit.Test
    public void LocalTime(){
        LocalDateTime localDateTime = LocalDateTime.now();

        Date date = Date.from( localDateTime.atZone( ZoneId.systemDefault()).toInstant());
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        System.out.println(df.format(date));

        String  date1=DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(localDateTime);
        System.out.println(date1);

    }



    @org.junit.Test
    public void upload() throws Exception {
        System.out.println("data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEASABIAAD" .substring("data:image/jpeg;base64," .length()));
    }

}
