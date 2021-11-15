package com.discipline.java.service;

import com.discipline.java.bean.Category;
import java.sql.SQLException;
import java.util.List;

public interface CategoryService {
    Category getCategoryById(int id) throws SQLException;
    List<Category> getAllCategory() throws SQLException;
}
