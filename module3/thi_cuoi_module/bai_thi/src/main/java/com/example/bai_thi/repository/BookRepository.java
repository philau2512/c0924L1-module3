package com.example.bai_thi.repository;

import com.example.bai_thi.model.Book;
import com.example.bai_thi.util.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookRepository implements IBookRepository {
    private final String SELECT_ALL_BOOK = "select * from book";
    private final String FIND_BOOK_BY_ID = "select * from book where book_id = ?";
    private final String UPDATE_QUANTITY_BOOK = "update book set quantity = ? where book_id = ?";

    @Override
    public List<Book> getBookList() {
        Connection connection = BaseRepository.getConnectDB();
        List<Book> bookList = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_BOOK);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String bookId = resultSet.getString("book_id");
                String bookTitle = resultSet.getString("title");
                String bookAuthor = resultSet.getString("author");
                String description = resultSet.getString("description");
                int quantity = resultSet.getInt("quantity");
                Book book = new Book(bookId, bookTitle, bookAuthor, description, quantity);
                bookList.add(book);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return bookList;
    }

    @Override
    public Book findById(String bookId) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(FIND_BOOK_BY_ID);
            preparedStatement.setString(1, bookId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String BookId = resultSet.getString("book_id");
                String BookTitle = resultSet.getString("title");
                String BookAuthor = resultSet.getString("author");
                String BookDescription = resultSet.getString("description");
                int BookQuantity = resultSet.getInt("quantity");
                Book book = new Book(BookId, BookTitle, BookAuthor, BookDescription, BookQuantity);
                return book;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public void updateQuantity(String bookId, int quantity) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_QUANTITY_BOOK);
            preparedStatement.setInt(1, quantity);
            preparedStatement.setString(2, bookId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
