package com.example.quan_ly_san_pham.controller;

import com.example.quan_ly_san_pham.model.Product;
import com.example.quan_ly_san_pham.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "ProductServlet", urlPatterns = "/products")
public class ProductServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showCreateForm(req, resp);
                break;
            case "edit":
                showEditForm(req, resp);
                break;
            case "delete":
                showDeleteForm(req, resp);
                break;
            case "view":
                viewProduct(req, resp);
            case "find":
                showFormFindProduct(req, resp);
            default:
                showListProduct(req, resp);
                break;
        }
    }

    private void showFormFindProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/product/find.jsp").forward(req, resp);
    }

    private void viewProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productService.findProductById(id);
        req.setAttribute("product", product);
        req.getRequestDispatcher("/product/view-details.jsp").forward(req, resp);
    }

    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.getRequestDispatcher("/product/create.jsp").forward(req, resp);
        } catch (ServletException e) {
            req.getRequestDispatcher("/product/error-404.jsp").forward(req, resp);
        }

    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productService.findProductById(id);
        if (product == null) {
            req.getRequestDispatcher("/product/error-404.jsp").forward(req, resp);
        } else {
            req.setAttribute("product", product);
            req.getRequestDispatcher("/product/edit.jsp").forward(req, resp);
        }
    }

    private void showDeleteForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productService.findProductById(id);
        if (product == null) {
            req.getRequestDispatcher("/product/error-404.jsp").forward(req, resp);
        } else {
            req.setAttribute("product", product);
            req.getRequestDispatcher("/product/delete.jsp").forward(req, resp);
        }
    }

    private void showListProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> productList = productService.getProductList();
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("/product/list.jsp").forward(req, resp);
    }

    // ------------------------------------ POST -----------------------------------------

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
            case "delete":
                deleteProduct(req, resp);
                break;
            case "find":
                findProduct(req, resp);
                break;
            default:
                break;
        }
    }

    private void createProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        int price = Integer.parseInt(req.getParameter("price"));

        Product product = new Product(id, name, price);
        boolean isCreate = productService.addProduct(product);
        if (isCreate) {
            req.setAttribute("message", "New product was created");
        } else {
            req.setAttribute("message", "Product was not created");
        }
        req.getRequestDispatcher("/product/create.jsp").forward(req, resp);
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        int price = Integer.parseInt(req.getParameter("price"));

        Product product = productService.findProductById(id);
        if (product == null) {
            req.getRequestDispatcher("/product/error-404.jsp").forward(req, resp);
        } else {
            product.setId(id);
            product.setName(name);
            product.setPrice(price);
            productService.updateProductById(id, product);
            req.setAttribute("product", product);
            req.setAttribute("message", "Product was updated");
            req.getRequestDispatcher("/product/edit.jsp").forward(req, resp);
        }
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productService.findProductById(id);
        if (product == null) {
            req.getRequestDispatcher("/product/error-404.jsp").forward(req, resp);
        } else {
            productService.deleteProductById(id);
            resp.sendRedirect("/products");
        }
    }

    private void findProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        List<Product> products = productService.findProductByName(name);
        if (products == null) {
            req.getRequestDispatcher("/product/error-404.jsp").forward(req, resp);
        } else {
            req.setAttribute("products", products);
            req.getRequestDispatcher("/product/findByName.jsp").forward(req, resp);
        }
    }
}
