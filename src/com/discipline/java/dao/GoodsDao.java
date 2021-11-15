package com.discipline.java.dao;

import com.discipline.java.bean.Category;
import com.discipline.java.bean.Goods;

import java.sql.SQLException;
import java.util.List;

public interface GoodsDao {


    List<Goods> getGoodsListByPage(int page, int size, int categoryId) throws SQLException;

    List<Goods> getALLGoodsListByPage(int page, int size) throws SQLException;

    Goods getGoodsById(int id) throws SQLException;

    List<Goods> getIndexGoodsList(int categoryId) throws SQLException;

    //获取随机三件同类别推荐商品
    List<Goods> getRecommendedGoodsList(int id,int categoryId) throws  SQLException;

    long getGoodsSum(int categoryId) throws SQLException;
}
