package com.discipline.java.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.Delayed;
import java.util.concurrent.TimeUnit;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order implements Delayed {
    private String id;
    private int uid;
    private double total;
    private String address;
    private String name;
    private String phone;
    private int status;
    private String lid;

    //todo 实体类使用Date类型使用查询映射字段会报转换错误
    private LocalDateTime orderTime;
    private LocalDateTime payTime;

    //回送前端处理
    private String otime;
    private String ptime;

    private long start;
    private long delay ;


    public Order(String id,int uid,double total,String address,String name,String phone,int status,LocalDateTime orderTime){
        this.id=id;
        this.uid=uid;
        this.total=total;
        this.address=address;
        this.name=name;
        this.phone=phone;
        this.status=status;
        this.orderTime=orderTime;
    }


    private List<OrderDetail>orderDetails;

    //获得延迟时间
    @Override
    public long getDelay(TimeUnit unit) {
        return unit.convert((start+delay) - System.currentTimeMillis(),TimeUnit.MILLISECONDS);
    }

    //延迟队列内部比较排序
    @Override
    public int compareTo(Delayed o) {
        Order o1 = (Order) o;
        return (int) (this.getDelay(TimeUnit.MILLISECONDS) - o.getDelay(TimeUnit.MILLISECONDS));
    }
}
