package com.example.bai_thi.controller;

import com.example.bai_thi.model.Book;
import com.example.bai_thi.model.BorrowCard;
import com.example.bai_thi.model.Student;
import com.example.bai_thi.service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "BorrowController", urlPatterns = "/borrow")
public class BorrowController extends HttpServlet {
    private IBookService bookService = new BookService();
    private IStudentService studentService = new StudentService();
    private IBorrowCardService borrowCardService = new BorrowCardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                showBorrowForm(req, resp);
                break;
            default:
                resp.sendRedirect("book");
        }
    }

    private void showBorrowForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bookId = req.getParameter("bookId");
        try {
            Book book = bookService.findById(bookId);
            if (book == null) {
                req.setAttribute("error", "Sách không tồn tại!");
                req.getRequestDispatcher("/views/book_list.jsp").forward(req, resp);
                return;
            }
            if (book.getQuantity() == 0) {
                req.setAttribute("error", "Sách đã hết, không thể mượn!");
                req.getRequestDispatcher("/views/book_list.jsp").forward(req, resp);
                return;
            }
            List<Student> studentList = studentService.getStudentList();
            req.setAttribute("book", book);
            req.setAttribute("studentList", studentList);
            req.getRequestDispatcher("/views/borrow_book.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
            req.getRequestDispatcher("/views/book_list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String borrowId = req.getParameter("borrowId");
        String bookId = req.getParameter("bookId");
        int studentId = Integer.parseInt(req.getParameter("studentId"));
        String returnDateStr = req.getParameter("returnDate");

        try {
            // Validation
            if (!borrowId.matches("MS-\\d{4}")) {
                req.setAttribute("error", "Mã mượn sách phải có định dạng MS-XXXX!");
                showBorrowForm(req, resp);
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            Date borrowDate = new Date(); // Ngày mượn là ngày hiện tại
            Date returnDate = sdf.parse(returnDateStr);

            // Kiểm tra ngày trả không được trước ngày mượn
            if (returnDate.before(borrowDate)) {
                req.setAttribute("error", "Ngày trả sách không được trước ngày mượn sách!");
                showBorrowForm(req, resp);
                return;
            }

            // Tạo BorrowCard
            BorrowCard borrowCard = new BorrowCard(borrowId, bookId, studentId, true, borrowDate, returnDate);
            borrowCardService.addBorrowCard(borrowCard);

            // Giảm số lượng sách
            Book book = bookService.findById(bookId);
            bookService.updateQuantity(bookId, book.getQuantity() - 1);

            // Lấy thông tin học sinh để hiển thị trong modal
            Student student = studentService.getStudentList().stream()
                    .filter(s -> s.getStudentId() == studentId)
                    .findFirst()
                    .orElse(null);

            // Truyền thông tin để hiển thị modal
            req.setAttribute("success", true);
            req.setAttribute("studentName", student != null ? student.getStudentName() : "Không xác định");

            resp.sendRedirect("book");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
            showBorrowForm(req, resp);
        }
    }
}
