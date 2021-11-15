package com.discipline.java.service.impl;

import com.discipline.java.bean.User;
import com.discipline.java.dao.UserDao;
import com.discipline.java.dao.impl.UserDaoImpl;
import com.discipline.java.service.UserService;
import com.discipline.java.utils.Base64Utils;
import com.discipline.java.utils.DruidUtils;
import com.discipline.java.utils.EmailUtils;

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
        user.setFlag(0);
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
        }
        DruidUtils.endTx();
        //base64解密
        return result;
    }
}
