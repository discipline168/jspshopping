package com.discipline.java.service;

import com.discipline.java.bean.Goods;
import java.sql.SQLException;
import java.util.List;

public interface GoodsService {

    List<Goods> getGoodsListByPage(int page, int size, int categoryId) throws SQLException;

    Goods getGoodsById(int id) throws SQLException;

    List<Goods> getIndexGoodsList(int categoryId) throws SQLException;

    List<Goods> getRecommendedGoodsList(int id,int categoryId) throws  SQLException;

    long getGoodsSum(int categoryId) throws  SQLException;

}
