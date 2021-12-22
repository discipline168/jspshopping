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
                    "SELECT * FROM tb_goods WHERE status= 1 ORDER BY id DESC LIMIT ?, ?",
                    new BeanListHandler<Goods>(Goods.class),
                    (page-1)*size,size);
        return queryRunner.query(
                "SELECT * FROM tb_goods WHERE status= 1 AND categoryid = ? ORDER BY id DESC LIMIT ?, ?",
                new BeanListHandler<Goods>(Goods.class),
                categoryId,(page-1)*size,size);
    }



    @Override
    public List<Goods> getALLGoodsListByPage(int page, int size, int categoryId) throws SQLException {
        //默认查询全部种类商品
        if(categoryId==0)
            return queryRunner.query(
                    "SELECT * FROM tb_goods ORDER BY id DESC LIMIT ?, ?",
                    new BeanListHandler<Goods>(Goods.class),
                    (page-1)*size,size);
        return queryRunner.query(
                "SELECT * FROM tb_goods WHERE categoryid = ? ORDER BY id DESC LIMIT ?, ?",
                new BeanListHandler<Goods>(Goods.class),
                categoryId,(page-1)*size,size);
    }

    @Override
    public Goods getGoodsById(int id) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_goods WHERE id = ?",
                new BeanHandler<Goods>(Goods.class), id);
    }

    @Override
    public List<Goods> getIndexGoodsList(int categoryId) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_goods WHERE categoryid = ? AND status= 1 ORDER BY sale DESC LIMIT 0,4",
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

    @Override
    public int insertGoods(Goods goods) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "INSERT INTO tb_goods(name, price, discount, picture, description, categoryid, others,sizes) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                goods.getName(),
                goods.getPrice(),
                goods.getDiscount(),
                goods.getPicture(),
                goods.getDescription(),
                goods.getCategoryid(),
                goods.getOthers(),
                goods.getSizes()
        );
    }

    @Override
    public int updateGoods(Goods goods) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "UPDATE tb_goods SET name = ?, price = ?,discount= ?,status= ?,picture= ?,description= ?,categoryid= ?,others= ?,sizes= ? WHERE id=?",
                goods.getName(),
                goods.getPrice(),
                goods.getDiscount(),
                goods.getStatus(),
                goods.getPicture(),
                goods.getDescription(),
                goods.getCategoryid(),
                goods.getOthers(),
                goods.getSizes(),
                goods.getId());
    }

}
