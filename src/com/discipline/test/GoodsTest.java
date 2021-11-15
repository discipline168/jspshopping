package com.discipline.test;

import com.discipline.java.bean.Category;
import com.discipline.java.bean.User;
import com.discipline.java.dao.CategoryDao;
import com.discipline.java.dao.impl.CategoryDaoImpl;
import com.discipline.java.service.CategoryService;
import com.discipline.java.service.impl.CategoryServiceImpl;


import java.sql.SQLException;

public class GoodsTest {

    private CategoryService categoryService;


    @org.junit.Before
    public void setUp() throws Exception {
        categoryService = new CategoryServiceImpl();
    }

    @org.junit.Test
    public void selectUserByUsername() throws SQLException {
        Category category = categoryService.getCategoryById(1);
        System.out.println(category);
    }
}
