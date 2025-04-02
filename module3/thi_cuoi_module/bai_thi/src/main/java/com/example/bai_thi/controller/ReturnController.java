package com.example.bai_thi.controller;

import com.example.bai_thi.service.BorrowCardService;
import com.example.bai_thi.service.IBorrowCardService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ReturnController", urlPatterns = "/borrowed")
public class ReturnController extends HttpServlet {
    private final IBorrowCardService borrowCardService = new BorrowCardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bookTitle = req.getParameter("bookTitle");
        String studentName = req.getParameter("studentName");
        try {
            req.setAttribute("borrowedBooks", borrowCardService.getBorrowedBooks(bookTitle, studentName)); // Sử dụng BorrowCardDto
            req.getRequestDispatcher("/views/borrowed_books.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
            req.getRequestDispatcher("/views/borrowed_books.jsp").forward(req, resp);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String borrowId = req.getParameter("borrowId");
        String bookId = req.getParameter("bookId");
        try {
            borrowCardService.returnBook(borrowId, bookId);
            resp.sendRedirect("borrowed");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi trả sách, vui lòng thử lại!");
            req.getRequestDispatcher("/views/borrowed_books.jsp").forward(req, resp);
        }
    }
}