package com.example.bai_thi.service;

import com.example.bai_thi.dto.BorrowCardDto;
import com.example.bai_thi.model.Book;
import com.example.bai_thi.model.BorrowCard;
import com.example.bai_thi.repository.BorrowCardRepository;
import com.example.bai_thi.repository.IBorrowCardRepository;

import java.util.List;

public class BorrowCardService implements IBorrowCardService {
    private IBorrowCardRepository borrowCardRepository = new BorrowCardRepository();
    private IBookService bookService = new BookService();

    @Override
    public boolean addBorrowCard(BorrowCard borrowCard) {
        return borrowCardRepository.addBorrowCard(borrowCard);
    }

    @Override
    public List<BorrowCardDto> getBorrowedBooks(String bookTitle, String studentName) {
        return borrowCardRepository.getBorrowedBooks(bookTitle, studentName);
    }

    @Override
    public boolean returnBook(String borrowId, String bookId) {
        Book book = bookService.findById(bookId); // Thêm dòng này để lấy thông tin sách
        boolean isReturned = borrowCardRepository.returnBook(borrowId, bookId);
        if (isReturned) {
            bookService.updateQuantity(bookId, book.getQuantity() + 1); // Tăng số lượng sách
        }
        return isReturned;
    }
}
