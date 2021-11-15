package com.discipline.java.dao.impl;

import com.discipline.java.bean.Cart;
import com.discipline.java.dao.CartDao;
import com.discipline.java.utils.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

public class CartDaoImpl implements CartDao {
    private QueryRunner queryRunner=new QueryRunner(DruidUtils.getDataSource());

    @Override
    public List<Cart> getCartList(int uid) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_cart WHERE uid = ? ORDER BY id DESC",
                new BeanListHandler<>(Cart.class),
                uid);
    }

    @Override
    public int deleteFromCart(int id) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "DELETE FROM tb_cart WHERE id=?",
                id);
    }

    @Override
    public Cart getCart(Cart cart) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_cart WHERE gid = ? AND size = ? AND uid = ?",
                new BeanHandler<>(Cart.class),
                cart.getGid(),
                cart.getSize(),
                cart.getUid());
    }

    @Override
    public int updateCart(Cart cart) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "UPDATE tb_cart SET quantity = ? WHERE id=?",
                cart.getQuantity(),
                cart.getId());
    }


    @Override
    public int insertCart(Cart cart) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "INSERT INTO tb_cart(gid, quantity,size,uid) VALUES (?, ?, ?, ?)",
                cart.getGid(),
                cart.getQuantity(),
                cart.getSize(),
                cart.getUid());
    }

    @Override
    public int clearCart(int uid) throws SQLException {
        return 0;
    }

    @Override
    public Cart getCartById(int id) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_cart WHERE id = ? ",
                new BeanHandler<>(Cart.class),
                id);
    }
}
