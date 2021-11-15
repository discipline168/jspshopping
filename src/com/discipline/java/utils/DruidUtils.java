package com.discipline.java.utils;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;


/**
 * @Author discipline
 * @Date 18:21 2021/11/9
 * @Description druid连接池工具类
 **/
public class DruidUtils {
    private static DruidDataSource dataSource=null;
    //用于事务控制
    private static final ThreadLocal<Connection> TL = new ThreadLocal<Connection>();

    //初始化Druid连接池
    static{
        try {
            Properties properties=new Properties();
            properties.load(DruidUtils.class.getClassLoader().getResourceAsStream("db.properties"));
            dataSource= (DruidDataSource) DruidDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //获取连接
    public static Connection getConnection() throws SQLException {
        Connection connection = TL.get();
        if(connection==null){
            connection = dataSource.getConnection();
            TL.set(connection);
        }
        return connection;
    }

    //开启事务锁
    public static void startTX() throws SQLException {
        Connection connection = getConnection();
        connection.setAutoCommit(false);
    }
    public static void endTx() throws SQLException {
        Connection connection = getConnection();
        connection.commit();
        connection.close();
        TL.remove();
    }
    public static DataSource getDataSource(){
        return dataSource;
    }

    //关闭事务锁并回滚
    public static void rollbackTX() throws SQLException {
        Connection connection = getConnection();
        //回滚
        connection.rollback();
        connection.close();
        TL.remove();
    }
}
