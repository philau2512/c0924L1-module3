package com.example.bai_thi.controller;

import com.example.bai_thi.model.Book;
import com.example.bai_thi.model.Student;
import com.example.bai_thi.service.BookService;
import com.example.bai_thi.service.IBookService;
import com.example.bai_thi.service.IStudentService;
import com.example.bai_thi.service.StudentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BookController", urlPatterns = "/book")
public class BookController extends HttpServlet {
    private IBookService bookService = new BookService();
    private IStudentService studentService = new StudentService();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "borrow":
                showBorrowForm(req, resp);
                break;
            default:
                showBookList(req, resp);
        }
    }

    private void showBorrowForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bookId = req.getParameter("bookId");
        try {
            Book book = bookService.findById(bookId);
            if (book == null) {
                req.setAttribute("error", "Sách không tồn tại!");
                showBookList(req, resp);
                return;
            }
            if (book.getQuantity() == 0) {
                req.setAttribute("error", "Sách đã hết, không thể mượn!");
                showBookList(req, resp);
                return;
            }
            List<Student> studentList = studentService.getStudentList();
            req.setAttribute("studentList", studentList);
            req.setAttribute("book", book);
            req.getRequestDispatcher("/views/borrow_book.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
            showBookList(req, resp);
        }
    }

    private void showBookList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Book> bookList = bookService.getBookList();
        req.setAttribute("bookList", bookList);
        req.getRequestDispatcher("/views/book_list.jsp").forward(req, resp);
    }
}
