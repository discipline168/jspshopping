package com.discipline.java.utils;

import org.apache.commons.lang3.RandomStringUtils;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
}
