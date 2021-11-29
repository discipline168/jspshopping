package com.discipline.java.service;

import com.discipline.java.bean.Cart;
import java.sql.SQLException;
import java.util.List;

public interface CartService {
    //获取购物车列表
    List<Cart> getCartList(int uid) throws SQLException;
    int deleteFromCart(List<Cart> cartList) throws SQLException;
    public int deleteFromCart(int id) throws SQLException;
    //更新购物车具体一行记录
    int updateCart(Cart cart) throws SQLException;
    int insertCart(Cart cart) throws SQLException;
    int clearCart(int uid) throws SQLException;

    Cart getCartById(int id)throws SQLException;

    double getTotalPrice(List<Cart>carts);

}
