package com.example.bai_tap_lam_them.service;

import com.example.bai_tap_lam_them.model.Product;
import com.example.bai_tap_lam_them.dto.ProductDto;
import com.example.bai_tap_lam_them.repository.IProductRepository;
import com.example.bai_tap_lam_them.repository.ProductRepository;

import java.util.List;

public class ProductService implements IProductService {
    private IProductRepository productRepository = new ProductRepository();

    @Override
    public List<ProductDto> getProductList() {
        return productRepository.getProductList();
    }

    @Override
    public boolean addProduct(Product product) {
        return productRepository.addProduct(product);
    }

    @Override
    public boolean deleteProductById(int id) {
        return productRepository.deleteProductById(id);
    }

    public boolean updateProductById(ProductDto productDto, int productId) {
        return productRepository.updateProductById(productDto, productId);
    }

    @Override
    public List<ProductDto> searchProduct(String name, String categoryId) {
        return productRepository.searchProduct(name, categoryId);
    }
}
