package com.discipline.java.service.impl;

import com.discipline.java.bean.Goods;
import com.discipline.java.dao.GoodsDao;
import com.discipline.java.dao.impl.GoodsDaoImpl;
import com.discipline.java.service.GoodsService;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GoodsServiceImpl implements GoodsService {

    private GoodsDao goodsDao=new GoodsDaoImpl();

    @Override
    public List<Goods> getGoodsListByPage(int page, int size, int categoryId) throws SQLException {

        return goodsDao.getGoodsListByPage(page,size,categoryId);
    }

    @Override
    public Goods getGoodsById(int id) throws SQLException {
        return goodsDao.getGoodsById(id);
    }

    @Override
    public List<Goods> getIndexGoodsList(int categoryId ) throws SQLException {
        return goodsDao.getIndexGoodsList(categoryId);
    }

    @Override
    public List<Goods> getRecommendedGoodsList(int id,int categoryId) throws SQLException {
        return goodsDao.getRecommendedGoodsList(id,categoryId);
    }

    @Override
    public long getGoodsSum(int categoryId) throws SQLException {
        return goodsDao.getGoodsSum(categoryId);
    }
}
