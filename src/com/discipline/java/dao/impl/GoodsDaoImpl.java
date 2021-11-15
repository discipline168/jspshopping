package com.discipline.java.dao.impl;

import com.discipline.java.bean.Category;
import com.discipline.java.bean.Goods;
import com.discipline.java.dao.GoodsDao;
import com.discipline.java.utils.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.List;

public class GoodsDaoImpl implements GoodsDao {

    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());

    @Override
    public List<Goods> getGoodsListByPage(int page, int size, int categoryId) throws SQLException {
        //默认查询全部种类商品
        if(categoryId==0)
            return queryRunner.query(
                    "SELECT * FROM tb_goods LIMIT ?, ?",
                    new BeanListHandler<Goods>(Goods.class),
                    (page-1)*size,size);
        return queryRunner.query(
                "SELECT * FROM tb_goods WHERE categoryid = ? LIMIT ?, ?",
                new BeanListHandler<Goods>(Goods.class),
                categoryId,(page-1)*size,size);
    }

    @Override
    public List<Goods> getALLGoodsListByPage(int page, int size) throws SQLException {
        return queryRunner.query(
                "SELECT * FROM tb_goods LIMIT ?, ?",
                new BeanListHandler<Goods>(Goods.class),
                (page-1)*size,size);
    }

    @Override
    public Goods getGoodsById(int id) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_goods WHERE id = ?",
                new BeanHandler<Goods>(Goods.class), id);
    }

    @Override
    public List<Goods> getIndexGoodsList(int categoryId) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_goods WHERE categoryid = ? ORDER BY sale DESC LIMIT 0,4",
                new BeanListHandler<Goods>(Goods.class), categoryId);
    }

    @Override
    public List<Goods> getRecommendedGoodsList(int id,int categoryId) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_goods WHERE id!= ? AND categoryid= ? ORDER BY RAND () LIMIT 3",
                new BeanListHandler<Goods>(Goods.class), id,categoryId);
    }

    @Override
    public long getGoodsSum(int categoryId) throws SQLException {
        //默认查询全部种类商品数量
        if(categoryId==0)
            return queryRunner.query("SELECT COUNT(*) FROM tb_goods",
                    new ScalarHandler<>());
        return queryRunner.query("SELECT COUNT(*) FROM tb_goods WHERE categoryid= ?",
                new ScalarHandler<>(),categoryId);
    }

}
