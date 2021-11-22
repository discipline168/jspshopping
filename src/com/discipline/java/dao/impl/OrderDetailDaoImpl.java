package com.discipline.java.dao.impl;

import com.discipline.java.bean.OrderDetail;
import com.discipline.java.dao.OrderDetailDao;
import com.discipline.java.utils.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

public class OrderDetailDaoImpl implements OrderDetailDao {
    private QueryRunner queryRunner=new QueryRunner(DruidUtils.getDataSource());

    @Override
    public List<OrderDetail> getOrderDetailList(String oid) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_orderdetail WHERE oid = ?",
                new BeanListHandler<>(OrderDetail.class),
                oid);
    }

    @Override
    public int insertOrderDetail(OrderDetail orderDetail) throws SQLException {
        return queryRunner.update(
                DruidUtils.getConnection(),
                "INSERT INTO tb_orderdetail(oid,gid,quantity,price,size) VALUES(?, ?, ?, ?, ?)",
                orderDetail.getOid(),orderDetail.getGid(),
                orderDetail.getQuantity(),orderDetail.getPrice(),orderDetail.getSize());
    }
}
