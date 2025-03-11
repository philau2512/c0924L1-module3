package com.example.customermanagement.controller;

import com.example.customermanagement.model.Customer;
import com.example.customermanagement.service.CustomerService;
import com.example.customermanagement.service.ICustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerServlet", urlPatterns = "/customers")
public class CustomerServlet extends HttpServlet {
    private ICustomerService customerService = new CustomerService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy Parameters (Dữ liệu request gửi đi) có name là "action".
        String action = req.getParameter("action");

        // Nếu dữ liệu request gửi đi không có "action" thì sẽ trả về null.
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                createCustomer(req, resp);
                break;
            case "edit":
                updateCustomer(req, resp);
                break;
            case "delete":
                deleteCustomer(req, resp);
                break;
            default:
                break;
        }
    }

    private void deleteCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Customer customer = customerService.findById(id);
        if (customer == null) {
            req.getRequestDispatcher("error-404.jsp").forward(req, resp);
        } else {
            customerService.remove(id);
            resp.sendRedirect("/customers");
        }
    }

    private void updateCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        Customer customer = customerService.findById(id);
        if (customer == null) {
            req.getRequestDispatcher("error-404.jsp").forward(req, resp);
        } else {
            customer.setName(name);
            customer.setEmail(email);
            customer.setAddress(address);
            customerService.update(id, customer);
            req.setAttribute("customer", customer);
            req.setAttribute("message", "Customer information was updated");
            req.getRequestDispatcher("customer/edit.jsp").forward(req, resp);
        }
    }

    private void createCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        int id = (int) (Math.random() * 10000);
        Customer customer = new Customer(id, name, email, address);
        customerService.save(customer);
        req.getRequestDispatcher("customer/create.jsp").forward(req, resp);
    }

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
                viewCustomer(req, resp);
                break;
            default:
                listCustomers(req, resp);
                break;
        }
    }

    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("customer/create.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Customer customer = customerService.findById(id);
        if (customer == null) {
            req.getRequestDispatcher("error-404.jsp").forward(req, resp);
        } else {
            req.setAttribute("customer", customer);
            req.getRequestDispatcher("customer/edit.jsp").forward(req, resp);
        }
    }

    private void showDeleteForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Customer customer = customerService.findById(id);
        if (customer == null) {
            req.getRequestDispatcher("error-404.jsp").forward(req, resp);
        } else {
            req.setAttribute("customer", customer);
            req.getRequestDispatcher("customer/delete.jsp").forward(req, resp);
        }
    }

    private void viewCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Customer customer = customerService.findById(id);
        if (customer == null) {
            req.getRequestDispatcher("error-404.jsp").forward(req, resp);
        } else {
            req.setAttribute("customer", customer);
            req.getRequestDispatcher("customer/view.jsp").forward(req, resp);
        }
    }

    private void listCustomers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Customer> customers = customerService.findAll();
        req.setAttribute("customers", customers);
        req.getRequestDispatcher("customer/list.jsp").forward(req, resp);
    }
}
