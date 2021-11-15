package com.discipline.java.dao;

import com.discipline.java.bean.Cart;
import java.sql.SQLException;
import java.util.List;

public interface CartDao {
     //获取购物车列表
     List<Cart> getCartList(int uid) throws SQLException;
     int deleteFromCart(int id) throws SQLException;
     //根据商品编号&尺寸(规格)&用户id获取唯一记录
     Cart getCart(Cart cart) throws SQLException;
     //更新购物车具体一行记录
     int updateCart(Cart cart) throws SQLException;
     int insertCart(Cart cart) throws SQLException;
     int clearCart(int uid) throws SQLException;
     Cart getCartById(int id)throws SQLException;
}
