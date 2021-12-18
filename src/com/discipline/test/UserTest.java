package com.discipline.test;

import com.discipline.java.bean.User;
import com.discipline.java.dao.UserDao;
import com.discipline.java.dao.impl.UserDaoImpl;
import com.discipline.java.utils.EmailUtils;
import org.junit.Test;

import java.io.IOException;
import java.sql.SQLException;

public class UserTest {
    private UserDao userDao;


    @org.junit.Before
    public void setUp() throws Exception {
        userDao = new UserDaoImpl();
    }

    @org.junit.Test
    public void selectUserByUsername() throws SQLException {
        User user = userDao.getUserByEmail("Ziph");
        System.out.println(user);
    }

    @Test
    public void insertUser() throws SQLException {
        User user = new User("Lazy", "123456", "mylifes1110@163.com", 1, 1, 1, "2018012218370268135d");
        int i = userDao.insertUser(user);
        System.out.println(i);
    }

    @Test
    public void activeUser() throws SQLException {
        int i = userDao.activeUser("mylifes1110@163.com", "2018012218370268135d");
        System.out.println(i);
    }



    @org.junit.Test
    public void testSendEmailTemplate() throws IOException {
        String s = EmailUtils.buildContent("578989689@qq.com", "<a href='#'>111</a>");
        System.out.println(s);
    }



    @org.junit.Test
    public void test02() throws IOException, SQLException {
        System.out.println(userDao.getUserNum());
    }

}
