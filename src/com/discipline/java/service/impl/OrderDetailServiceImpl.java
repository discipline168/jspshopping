package com.discipline.java.service.impl;

import com.discipline.java.bean.Cart;
import com.discipline.java.bean.Goods;
import com.discipline.java.bean.OrderDetail;
import com.discipline.java.dao.GoodsDao;
import com.discipline.java.dao.OrderDetailDao;
import com.discipline.java.dao.impl.GoodsDaoImpl;
import com.discipline.java.dao.impl.OrderDetailDaoImpl;
import com.discipline.java.service.OrderDetailService;
import com.discipline.java.utils.DruidUtils;

import java.sql.SQLException;
import java.util.List;

public class OrderDetailServiceImpl implements OrderDetailService {
    private OrderDetailDao orderDetailDao=new OrderDetailDaoImpl();
    private GoodsDao goodsDao=new GoodsDaoImpl();

    @Override
    public List<OrderDetail> getOrderDetailList(String oid) throws SQLException {
        Goods goods;
        List<OrderDetail> orderDetailList = orderDetailDao.getOrderDetailList(oid);
        for (OrderDetail detail:orderDetailList){
            goods= goodsDao.getGoodsById(detail.getGid());
            if(goods!=null)
                detail.setName(goods.getName());
        }
        return orderDetailList;
    }

    @Override
    public int insertOrderDetails(List<Cart> cartList,String oid) throws SQLException {
        OrderDetail orderDetail=new OrderDetail();
        orderDetail.setOid(oid);
        DruidUtils.startTX();
        try {
            for(Cart cart:cartList){
                orderDetail.setGid(cart.getGid());
                orderDetail.setPrice(cart.getGoods().getPrice()*cart.getGoods().getDiscount());
                orderDetail.setQuantity(cart.getQuantity());
                orderDetail.setSize(cart.getSize());

                orderDetailDao.insertOrderDetail(orderDetail);
            }

        }catch (Exception e){
            e.printStackTrace();
            DruidUtils.rollbackTX();
            throw e;
        }
        DruidUtils.endTx();
        return 1;
    }
}
