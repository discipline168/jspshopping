package com.discipline.java.dao.impl;

import com.discipline.java.bean.Category;
import com.discipline.java.dao.CategoryDao;
import com.discipline.java.utils.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

public class CategoryDaoImpl implements CategoryDao {

    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());

    @Override
    public Category getCategoryById(int id) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_category WHERE id= ?",
                new BeanHandler<Category>(Category.class),id);
    }

    @Override
    public List<Category> getAllCategory() throws SQLException {
        return queryRunner.query("SELECT * FROM tb_category",
                new BeanListHandler<Category>(Category.class));
    }
}
