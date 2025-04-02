package com.example.bai_thi.repository;

import com.example.bai_thi.dto.BorrowCardDto;
import com.example.bai_thi.model.BorrowCard;
import com.example.bai_thi.util.BaseRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BorrowCardRepository implements IBorrowCardRepository {
    private String ADD_BORROW_CARD = "INSERT INTO borrow_card (borrow_id, book_id, student_id, status, borrow_date, return_date) VALUES (?, ?, ?, ?, ?, ?)";
    private String GET_BORROW_CARD = "SELECT bc.*, b.title, s.full_name " +
            "FROM borrow_card bc " +
            "JOIN book b ON bc.book_id = b.book_id " +
            "JOIN student s ON bc.student_id = s.student_id " +
            "WHERE bc.status = TRUE " +
            "AND b.title LIKE ? " +
            "AND s.full_name LIKE ?";
    private String RETURN_BOOK = "UPDATE borrow_card SET status = FALSE, return_date = CURDATE() WHERE borrow_id = ?";

    @Override
    public boolean addBorrowCard(BorrowCard borrowCard) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(ADD_BORROW_CARD);
            preparedStatement.setString(1, borrowCard.getBorrowId());
            preparedStatement.setString(2, borrowCard.getBookId());
            preparedStatement.setInt(3, borrowCard.getStudentId());
            preparedStatement.setBoolean(4, borrowCard.isStatus());
            preparedStatement.setDate(5, new Date(borrowCard.getBorrowDate().getTime()));
            preparedStatement.setDate(6, new Date(borrowCard.getReturnDate().getTime()));
            int effectRows = preparedStatement.executeUpdate();
            return effectRows == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<BorrowCardDto> getBorrowedBooks(String bookTitle, String studentName) {
        Connection connection = BaseRepository.getConnectDB();
        List<BorrowCardDto> borrowedBooks = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(GET_BORROW_CARD);
            preparedStatement.setString(1, "%" + (bookTitle != null ? bookTitle : "") + "%");
            preparedStatement.setString(2, "%" + (studentName != null ? studentName : "") + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String borrowId = resultSet.getString("borrow_id");
                String bookId = resultSet.getString("book_id");
                int studentId = resultSet.getInt("student_id");
                boolean status = resultSet.getBoolean("status");
                Date borrowDate = resultSet.getDate("borrow_date");
                Date returnDate = resultSet.getDate("return_date");
                String bookTitleResult = resultSet.getString("title"); // Lấy tên sách
                String studentNameResult = resultSet.getString("full_name");

                // Tạo BorrowCardDto và gán dữ liệu
                BorrowCardDto borrowCardDto = new BorrowCardDto(borrowId, bookId, studentId, status, borrowDate, returnDate, bookTitleResult, studentNameResult);
                borrowedBooks.add(borrowCardDto);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return borrowedBooks;
    }

    @Override
    public boolean returnBook(String borrowId, String bookId) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(RETURN_BOOK);
            preparedStatement.setString(1, borrowId);
            return preparedStatement.executeUpdate() == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
