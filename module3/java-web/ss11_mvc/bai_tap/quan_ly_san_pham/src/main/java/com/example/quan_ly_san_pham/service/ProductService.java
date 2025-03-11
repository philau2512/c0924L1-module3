package com.example.quan_ly_san_pham.service;

import com.example.quan_ly_san_pham.model.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductService implements IProductService {
    private static List<Product> productList = new ArrayList<>();

    static {
        productList.add(new Product(1, "Balo", 5000));
        productList.add(new Product(2, "Ao Dai", 7000));
        productList.add(new Product(3, "Tui Xach", 10000));
    }

    @Override
    public List<Product> getProductList() {
        return productList;
    }

    @Override
    public boolean addProduct(Product product) {
        productList.add(product);
        return true;
    }

    @Override
    public Product findProductById(int id) {
        for (Product product : productList) {
            if (product.getId() == id) {
                return product;
            }
        }
        return null;
    }

    @Override
    public List<Product> findProductByName(String name) {
        List<Product> products = new ArrayList<>();
        for (Product product : productList) {
            if (product.getName().toLowerCase().contains(name.toLowerCase())) {
                products.add(product);
            }
        }
        if (products.isEmpty()) {
            return null;
        }
        return products;
    }

    @Override
    public boolean updateProductById(int id, Product product) {
        for (int i = 0; i < productList.size(); i++) {
            if (productList.get(i).getId() == id) {
                productList.set(i, product);
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean deleteProductById(int id) {
        for (int i = 0; i < productList.size(); i++) {
            if (productList.get(i).getId() == id) {
                productList.remove(i);
                return true;
            }
        }
        return false;
    }


}
