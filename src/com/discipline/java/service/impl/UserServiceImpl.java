package com.discipline.java.service.impl;

import com.discipline.java.bean.User;
import com.discipline.java.dao.UserDao;
import com.discipline.java.dao.impl.UserDaoImpl;
import com.discipline.java.service.UserService;
import com.discipline.java.utils.*;

import java.sql.SQLException;
import java.util.UUID;

public class UserServiceImpl implements UserService {
    private UserDao userDao=new UserDaoImpl();

    @Override
    public User getUserByEmail(String email) throws SQLException {
        return userDao.getUserByEmail(email);
    }

    @Override
    public User getUser(String email, String password) throws SQLException {
        return userDao.getUser(email,password);
    }

    @Override
    public int insertUser(User user) throws SQLException {
        //开启事务
        DruidUtils.startTX();
        user.setFlag(Constant.USER_NO_ACTIVATED);
        user.setCode(UUID.randomUUID().toString());

        int result = 0;

        try {
            result = userDao.insertUser(user);
        } catch (SQLException e) {
            e.printStackTrace();
            DruidUtils.rollbackTX();
            throw e;
        }

        //发送激活邮件
        EmailUtils.sendMessage(user);
        DruidUtils.endTx();

        return result;
    }

    @Override
    public int activeUser(String email, String code) throws SQLException {

        DruidUtils.startTX();
        int result = userDao.activeUser(Base64Utils.decode(email), Base64Utils.decode(code));
        //删除此前冗余的相同邮箱但未激活的账号数据
        if(result>0){
            userDao.deleteDuplicateEmails(Base64Utils.decode(email));
        }else{
            DruidUtils.rollbackTX();
        }
        DruidUtils.endTx();
        //base64解密
        return result;
    }

    @Override
    public int pay(User user, double total) throws SQLException {
        user = userDao.getUser(user.getEmail(), user.getPassword());
        if(user==null)
            return 0;
        if(total>user.getBalance())
            return 0;
        return userDao.updateBalance(user.getId(), (user.getBalance() - total));

    }

    /*@Override
    public int updateBalance(int uid, double balance) throws SQLException {
        return userDao.updateBalance(uid,balance);
    }*/

    @Override
    public int applyCoupon(int uid) throws SQLException {
        int result = 0;
        DruidUtils.startTX();
        try {
            result=userDao.applyCoupon(uid);
        }catch (SQLException e){
            e.printStackTrace();
            DruidUtils.rollbackTX();
        }
        DruidUtils.endTx();
        return result;
    }

    @Override
    public Long getUserNum() throws SQLException {
        return userDao.getUserNum();
    }
}
