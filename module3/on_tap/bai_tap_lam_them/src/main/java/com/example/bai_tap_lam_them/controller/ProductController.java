package com.example.bai_tap_lam_them.controller;

import com.example.bai_tap_lam_them.dto.ProductDto;
import com.example.bai_tap_lam_them.model.Category;
import com.example.bai_tap_lam_them.model.Product;
import com.example.bai_tap_lam_them.service.CategoryService;
import com.example.bai_tap_lam_them.service.ICategoryService;
import com.example.bai_tap_lam_them.service.IProductService;
import com.example.bai_tap_lam_them.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductController", urlPatterns = "/products")
public class ProductController extends HttpServlet {
    private IProductService productService = new ProductService();
    private ICategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "search":
                seachProduct(req, resp);
                break;
            case "delete":
                deleteProductById(req, resp);
                break;
            case "create":
                showCreateForm(req, resp);
            default:
                showListProduct(req, resp);
                break;
        }
    }

    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categoryList = categoryService.getAllCategory();
        req.setAttribute("categoryList", categoryList);
        req.getRequestDispatcher("/views/product/create.jsp").forward(req, resp);
    }

    private void deleteProductById(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("deleteId"));
        boolean isDelete = productService.deleteProductById(id);
        String message = "Delete product failed!";
        if (isDelete) {
            message = "Delete product successful!";
        }
        resp.sendRedirect("/products?mess=" + message);
    }

    private void seachProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchName = req.getParameter("searchName");
        String categoryId = req.getParameter("categoryId");
        if (categoryId == null) {
            categoryId = "";
        }
        List<ProductDto> searchList = productService.searchProduct(searchName, categoryId);
        req.setAttribute("searchName", searchName);
        req.setAttribute("categoryId", categoryId);

        // Lấy danh sách category để hiển thị trong dropdown
        List<Category> categoryList = categoryService.getAllCategory();
        req.setAttribute("categoryList", categoryList);

        req.setAttribute("productList", searchList);
        req.getRequestDispatcher("/views/product/list.jsp").forward(req, resp);
    }

    private void showListProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ProductDto> productList = productService.getProductList();
        List<Category> categoryList = categoryService.getAllCategory();
        req.setAttribute("productList", productList);
        req.setAttribute("categoryList", categoryList);
        req.getRequestDispatcher("/views/product/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                createProduct(req, resp);
                break;
            case "edit":
                updateProduct(req, resp);
                break;
            default:
                showListProduct(req, resp);
                break;
        }
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        String unit = req.getParameter("unit");
        double pricePerUnit = Double.parseDouble(req.getParameter("pricePerUnit"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));

        ProductDto productDto = new ProductDto();
        productDto.setId(id);
        productDto.setCode(code);
        productDto.setName(name);
        productDto.setUnit(unit);
        productDto.setPricePerUnit(pricePerUnit);
        productDto.setCategoryId(categoryId);

        boolean isUpdated = productService.updateProductById(productDto, id);
        String message = "Update product failed!";
        if (isUpdated) {
            message = "Update product successful!";
        }
        resp.sendRedirect("/products?mess=" + message);
    }

    private void createProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String productCode = req.getParameter("code");
        String productName = req.getParameter("name");
        String unit = req.getParameter("unit");
        double pricePerUnit = Double.parseDouble(req.getParameter("pricePerUnit"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));

        Product product = new Product(productCode, productName, unit, pricePerUnit, categoryId);
        boolean isCreated = productService.addProduct(product);
        String message = "Create product failed!";
        if (isCreated) {
            message = "Create product successful!";
        }
        resp.sendRedirect("/products?mess=" + message);
    }
}
