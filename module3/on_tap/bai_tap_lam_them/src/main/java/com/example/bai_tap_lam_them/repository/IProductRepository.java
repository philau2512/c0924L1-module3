package com.example.bai_tap_lam_them.repository;

import com.example.bai_tap_lam_them.model.Product;
import com.example.bai_tap_lam_them.dto.ProductDto;

import java.util.List;

public interface IProductRepository {
    List<ProductDto> getProductList();

    boolean addProduct(Product product);

    boolean deleteProductById(int id);

    boolean updateProductById(ProductDto productDto, int productId);

    List<ProductDto> searchProduct(String name, String categoryId);
}
