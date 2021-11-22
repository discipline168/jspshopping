package com.discipline.java.dao;

import com.discipline.java.bean.User;
import java.sql.SQLException;

public interface UserDao {

    User getUserByEmail(String email) throws SQLException;

    User getUser(String email, String password) throws SQLException;

    int insertUser(User user) throws SQLException;

    int activeUser(String email, String code) throws SQLException;

    //删除数据库里相同email的未激活的数据
    int deleteDuplicateEmails(String email) throws SQLException;

    int updateBalance(int uid,double balance) throws SQLException;

    int applyCoupon(int uid)throws SQLException;

}
