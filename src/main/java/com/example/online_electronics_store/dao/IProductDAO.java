package com.example.online_electronics_store.dao;

import com.example.online_electronics_store.model.Product;

import java.sql.SQLException;
import java.util.List;

public interface IProductDAO extends InterfaceDAO<Product, Long> {
    Product findByName(String name) throws SQLException;
    List<Product> sort(String condition) throws SQLException;
}
