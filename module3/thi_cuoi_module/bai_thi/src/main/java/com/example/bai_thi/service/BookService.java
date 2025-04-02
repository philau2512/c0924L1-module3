package com.example.bai_thi.service;

import com.example.bai_thi.model.Book;
import com.example.bai_thi.repository.BookRepository;
import com.example.bai_thi.repository.IBookRepository;

import java.util.List;

public class BookService implements IBookService {
    private IBookRepository bookRepository = new BookRepository();

    @Override
    public List<Book> getBookList() {
        return bookRepository.getBookList();
    }

    @Override
    public Book findById(String bookId) {
        return bookRepository.findById(bookId);
    }

    @Override
    public void updateQuantity(String bookId, int quantity) {
        bookRepository.updateQuantity(bookId, quantity);
    }
}
