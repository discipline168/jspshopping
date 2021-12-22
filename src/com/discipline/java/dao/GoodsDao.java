package com.discipline.java.dao;

import com.discipline.java.bean.Category;
import com.discipline.java.bean.Goods;

import java.sql.SQLException;
import java.util.List;

public interface GoodsDao {


    //分页获取"在售"商品信息
    List<Goods> getGoodsListByPage(int page, int size, int categoryId) throws SQLException;
    //分页获取所有商品信息[admin]
    List<Goods> getALLGoodsListByPage(int page, int size, int categoryId) throws SQLException;

    Goods getGoodsById(int id) throws SQLException;

    List<Goods> getIndexGoodsList(int categoryId) throws SQLException;

    //获取随机三件同类别推荐商品
    List<Goods> getRecommendedGoodsList(int id,int categoryId) throws  SQLException;

    long getGoodsSum(int categoryId) throws SQLException;

    int insertGoods(Goods goods)throws SQLException;

    int updateGoods(Goods goods)throws SQLException;
}
