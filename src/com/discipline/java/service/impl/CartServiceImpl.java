package com.discipline.java.service.impl;

import com.discipline.java.bean.Cart;
import com.discipline.java.bean.Goods;
import com.discipline.java.dao.CartDao;
import com.discipline.java.dao.GoodsDao;
import com.discipline.java.dao.impl.CartDaoImpl;
import com.discipline.java.dao.impl.GoodsDaoImpl;
import com.discipline.java.service.CartService;

import java.sql.SQLException;
import java.util.List;

public class CartServiceImpl implements CartService {
    private CartDao cartDao=new CartDaoImpl();
    private GoodsDao goodsDao=new GoodsDaoImpl();

    @Override
    public List<Cart> getCartList(int uid) throws SQLException {
        List<Cart> cartList = cartDao.getCartList(uid);
        Goods goods;
        for (Cart cart:cartList){
            goods = goodsDao.getGoodsById(cart.getGid());
            if(goods!=null)
                cart.setGoods(goods);
        }
        return cartList;
    }

    @Override
    public int deleteFromCart(int id) throws SQLException {
        return cartDao.deleteFromCart(id);
    }

    @Override
    public int deleteFromCart(List<Cart> cartList) throws SQLException {
        int result=1;
        for(Cart cart:cartList){
            result=cartDao.deleteFromCart(cart.getId());
            if(result==0)
                break;
        }
        return result;
    }

    @Override
    public int updateCart(Cart cart) throws SQLException {
        return cartDao.updateCart(cart);
    }

    @Override
    public int insertCart(Cart cart) throws SQLException {
        //查询用户数据库中是否已存在该条商品记录(商品编号 & 尺码/规格 & 用户id 决定一行记录)
        Cart record = cartDao.getCart(cart);
        //存在则在此条记录上更新数量
        if(record!=null) {
            record.setQuantity(record.getQuantity() +
                    (cart.getQuantity() == 0 ? 1 : cart.getQuantity()));
            return cartDao.updateCart(record);
        }
        //否则直接插入
        return cartDao.insertCart(cart);
    }

    @Override
    public int clearCart(int uid) throws SQLException {
        return 0;
    }

    @Override
    public Cart getCartById(int id) throws SQLException {
        Cart cart = cartDao.getCartById(id);
        if(cart!=null){
            Goods goods = goodsDao.getGoodsById(cart.getGid());
            if(goods!=null)
                cart.setGoods(goods);
        }
        return cart;
    }

    @Override
    public double getTotalPrice(List<Cart> carts) {
        double sum=0;
        for(Cart cart:carts){
            sum+=(cart.getGoods().getPrice()*cart.getGoods().getDiscount()*cart.getQuantity());
        }
        return sum;
    }
}
