package com.discipline.java.dao.impl;

import com.discipline.java.bean.Order;
import com.discipline.java.dao.OrderDao;
import com.discipline.java.utils.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public class OrderDaoImpl implements OrderDao {
    private QueryRunner queryRunner=new QueryRunner(DruidUtils.getDataSource());

    @Override
    public List<Order> getOrderList(int uid) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_order WHERE uid = ? ORDER BY orderTime DESC",
                new BeanListHandler<>(Order.class),
                uid);
    }

    @Override
    public Order getOrder(String id) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_order WHERE id = ?",
                new BeanHandler<>(Order.class),
                id);
    }

    @Override
    public int updateOrderStatus(String id,int status) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "UPDATE tb_order SET status = ? WHERE id = ?",
                status,id);
    }

    @Override
    public int insertOrder(Order order) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "INSERT INTO tb_order(id,uid,total,orderTime,address,name,phone) VALUES (?, ?, ?, ? ,?, ?, ?)",
                order.getId(),order.getUid(),order.getTotal(),
                order.getOrderTime(),order.getAddress(),order.getName(),order.getPhone()
                );
    }

    @Override
    public int updatePayTime(String id) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "UPDATE tb_order SET payTime = ? WHERE id = ?",
                LocalDateTime.now(),id);
    }
}
