package com.example.bai_thi.repository;

import com.example.bai_thi.model.Book;

import java.util.List;

public interface IBookRepository {
    List<Book> getBookList();
    Book findById(String bookId);
    void updateQuantity(String bookId, int quantity);
}
