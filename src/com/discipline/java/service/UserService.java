package com.discipline.java.service;

import com.discipline.java.bean.User;

import java.sql.SQLException;

public interface UserService {

    User getUserByEmail(String email) throws SQLException;

    User getUser(String email, String password) throws SQLException;

    int insertUser(User user) throws SQLException;

    int activeUser(String email, String code) throws SQLException;


}
