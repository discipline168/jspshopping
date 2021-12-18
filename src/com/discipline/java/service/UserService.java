package com.discipline.java.service;

import com.discipline.java.bean.User;

import java.sql.SQLException;

public interface UserService {

    User getUserByEmail(String email) throws SQLException;

    User getUser(String email, String password) throws SQLException;

    int insertUser(User user) throws SQLException;

    int activeUser(String email, String code) throws SQLException;

    int pay(User user,double total) throws SQLException;

    //int updateBalance(int uid,double balance) throws SQLException;

    int applyCoupon(int uid)throws SQLException;

    Long getUserNum()throws SQLException;

}
