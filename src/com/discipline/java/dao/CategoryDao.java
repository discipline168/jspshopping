package com.discipline.java.dao;

import com.discipline.java.bean.Category;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface CategoryDao {
    Category getCategoryById(int id) throws SQLException;
    List<Category> getAllCategory() throws SQLException;
}
