package com.example.quan_ly_san_pham.service;

import com.example.quan_ly_san_pham.model.Product;
import com.example.quan_ly_san_pham.repository.IProductRepository;
import com.example.quan_ly_san_pham.repository.ProductRepository;

import java.util.ArrayList;
import java.util.List;

public class ProductService implements IProductService {
    private final IProductRepository productRepository = new ProductRepository();

    @Override
    public List<Product> getProductList() {
        return productRepository.getProductList();
    }

    @Override
    public boolean addProduct(Product product) {
        return productRepository.addProduct(product);
    }

    @Override
    public Product findProductById(int id) {
        return productRepository.findProductById(id);
    }

    @Override
    public List<Product> findProductByName(String name) {
        return productRepository.findProductByName(name);
    }

    @Override
    public boolean updateProductById(int id, Product product) {
        return productRepository.updateProductById(id, product);
    }

    @Override
    public boolean deleteProductById(int id) {
        return productRepository.deleteProductById(id);
    }
}
