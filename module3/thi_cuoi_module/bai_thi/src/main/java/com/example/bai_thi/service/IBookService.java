package com.example.bai_thi.service;

import com.example.bai_thi.model.Book;

import java.util.List;

public interface IBookService {
    List<Book> getBookList();
    Book findById(String bookId);
    void updateQuantity(String bookId, int quantity);
}
