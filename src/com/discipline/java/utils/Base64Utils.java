package com.discipline.java.utils;

import java.util.Base64;

public class Base64Utils {

    public static String encode(String msg){
        return Base64.getEncoder().encodeToString(msg.getBytes());
    }

    public static String decode(String msg){
        return new String(Base64.getDecoder().decode(msg));
    }
}