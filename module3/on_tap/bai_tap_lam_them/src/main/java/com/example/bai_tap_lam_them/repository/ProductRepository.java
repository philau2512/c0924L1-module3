package com.example.bai_tap_lam_them.repository;

import com.example.bai_tap_lam_them.model.Product;
import com.example.bai_tap_lam_them.dto.ProductDto;
import com.example.bai_tap_lam_them.util.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository implements IProductRepository {
    private String SELECT_ALL = "SELECT p.id, p.product_code, p.product_name, p.unit, p.price_per_unit, p.category_id, c.category_name FROM products p JOIN category c ON p.category_id = c.id order by p.product_code";
    private String SEARCH_BY_NAME = "select p.id, p.product_code, p.product_name, p.unit, p.price_per_unit, p.category_id, c.category_name from products p join category c on p.category_id = c.id where p.product_name like ?";
    private String SEARCH_BY_NAME_AND_CATEGORY_ID = "select p.id, p.product_code, p.product_name, p.unit, p.price_per_unit, p.category_id, c.category_name from products p join category c on p.category_id = c.id where p.product_name like ? and c.id = ?";
    private String DELETE_PRODUCT_BY_ID = "delete from products where id = ?";
    private String INSERT_PRODUCT = "insert into products (product_code, product_name, unit, price_per_unit, category_id) values(?, ?, ?, ?, ?)";
    private String UPDATE_PRODUCT_BY_ID = "UPDATE products SET product_code = ?, product_name = ?, unit = ?, price_per_unit = ?, category_id = ? WHERE id = ?";
    @Override
    public List<ProductDto> getProductList() {
        List<ProductDto> productList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String productCode = resultSet.getString("product_code");
                String productName = resultSet.getString("product_name");
                String productUnit = resultSet.getString("unit");
                Double productPrice = resultSet.getDouble("price_per_unit");
                String categoryName = resultSet.getString("category_name");
                int categoryId = resultSet.getInt("category_id");
                ProductDto productDto = new ProductDto(id, productCode, productName, productUnit, productPrice, categoryName, categoryId);
                productList.add(productDto);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return productList;
    }

    @Override
    public boolean addProduct(Product product) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PRODUCT);
            preparedStatement.setString(1, product.getCode());
            preparedStatement.setString(2, product.getName());
            preparedStatement.setString(3, product.getUnit());
            preparedStatement.setDouble(4, product.getPricePerUnit());
            preparedStatement.setInt(5, product.getCategoryId());
            return preparedStatement.executeUpdate() == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    public boolean deleteProductById(int id) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PRODUCT_BY_ID);
            preparedStatement.setInt(1, id);
            int effectedRowCount = preparedStatement.executeUpdate();
            return effectedRowCount == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    public boolean updateProductById(ProductDto product, int productId) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRODUCT_BY_ID);
            preparedStatement.setString(1, product.getCode());
            preparedStatement.setString(2, product.getName());
            preparedStatement.setString(3, product.getUnit());
            preparedStatement.setDouble(4, product.getPricePerUnit());
            preparedStatement.setInt(5, product.getCategoryId());
            preparedStatement.setInt(6, productId);
            return preparedStatement.executeUpdate() == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<ProductDto> searchProduct(String name, String categoryId) {
        List<ProductDto> productList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = null;
            if (categoryId.equals("")) {
                preparedStatement = connection.prepareStatement(SEARCH_BY_NAME);
                preparedStatement.setString(1, "%" + name + "%");
            } else {
                preparedStatement = connection.prepareStatement(SEARCH_BY_NAME_AND_CATEGORY_ID);
                preparedStatement.setString(1, "%" + name + "%");
                preparedStatement.setString(2, categoryId);
            }
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String productCode = resultSet.getString("product_code");
                String productName = resultSet.getString("product_name");
                String productUnit = resultSet.getString("unit");
                Double productPrice = resultSet.getDouble("price_per_unit");
                String categoryName = resultSet.getString("category_name");
                int cateId = resultSet.getInt("category_id");
                ProductDto productDto = new ProductDto(id, productCode, productName, productUnit, productPrice, categoryName, cateId);
                productList.add(productDto);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return productList;
    }
}
