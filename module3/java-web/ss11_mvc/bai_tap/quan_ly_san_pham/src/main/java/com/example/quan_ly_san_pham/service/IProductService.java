package com.example.quan_ly_san_pham.service;

import com.example.quan_ly_san_pham.model.Product;

import java.util.List;

public interface IProductService {
    List<Product> getProductList();

    boolean addProduct(Product product);

    Product findProductById(int id);

    List<Product> findProductByName(String name);

    boolean updateProductById(int id, Product product);

    boolean deleteProductById(int id);
}
