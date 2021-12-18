package com.discipline.java.utils;

import org.apache.commons.lang3.RandomStringUtils;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class OrderUtils {

    //生成订单号 时间戳+3位随机数
    public static String genrateOrderId(){
        //时间-精确到毫秒
        DateTimeFormatter ofPattern = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
        String localDate = LocalDateTime.now().format(ofPattern);
        //3位随机数
        String randomNumeric = RandomStringUtils.randomNumeric(3);
        return localDate + randomNumeric;
    }

    //将LocalDateTime转换成格式化时间字符串回送给前端处理
    public static String transform(LocalDateTime time){
        return  DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(time);
    }




    //获取过去7天内的日期数组
    public static ArrayList<String> getPast7Days() {
        ArrayList<String> pastDaysList = new ArrayList<>();
        for (int i =0;i<7;i++) {
            pastDaysList.add(getPastDate(i));
        }
        return pastDaysList;
    }


    //获取过去第n天的日期
    public static String getPastDate(int past) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - past);
        Date today = calendar.getTime();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String result = format.format(today);
        return result;
    }
}
