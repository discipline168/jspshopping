package com.discipline.java.service.impl;

import com.discipline.java.bean.Category;
import com.discipline.java.dao.CategoryDao;
import com.discipline.java.dao.impl.CategoryDaoImpl;
import com.discipline.java.service.CategoryService;

import java.sql.SQLException;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {

    private CategoryDao categoryDao=new CategoryDaoImpl();

    @Override
    public Category getCategoryById(int id) throws SQLException {
        return categoryDao.getCategoryById(id);
    }

    @Override
    public List<Category> getAllCategory() throws SQLException {
        return categoryDao.getAllCategory();
    }
}
