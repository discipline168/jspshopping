package com.discipline.java.dao.impl;

import com.discipline.java.bean.User;
import com.discipline.java.dao.UserDao;
import com.discipline.java.utils.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;

public class UserDaoImpl implements UserDao {

    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());


    @Override
    public User getUserByEmail(String email) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_user WHERE email = ? AND flag=1",
                new BeanHandler<User>(User.class),
                email);
    }

    @Override
    public User getUser(String email, String password) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_user WHERE email = ? AND password=?",
                new BeanHandler<User>(User.class),
                email,
                password);
    }

    @Override
    public int insertUser(User user) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "INSERT INTO tb_user(username, password, email, gender, flag, role, code) VALUES (?, ?, ?, ?, ?, ?, ?)",
                user.getUsername(),
                user.getPassword(),
                user.getEmail(),
                user.getGender(),
                user.getFlag(),
                user.getRole(),
                user.getCode());
    }

    @Override
    public int activeUser(String email, String code) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "UPDATE tb_user SET flag = 1 WHERE email = ? AND code = ?",
                email,
                code);
    }

    @Override
    public int deleteDuplicateEmails(String email) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "DELETE FROM tb_user  WHERE email = ? AND flag = 0",
                email);
    }

    @Override
    public int updateBalance(int uid,double balance) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "UPDATE tb_user SET balance =  ? WHERE id = ?",
                balance,
                uid);
    }

    @Override
    public int applyCoupon(int uid) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "UPDATE tb_user SET balance =  balance + 666 WHERE id = ?",
                uid);
    }

    @Override
    public Long getUserNum() throws SQLException {
        return queryRunner.query("SELECT COUNT(*) FROM tb_user WHERE flag=1 AND role =0",
                new ScalarHandler<>());
    }
}
