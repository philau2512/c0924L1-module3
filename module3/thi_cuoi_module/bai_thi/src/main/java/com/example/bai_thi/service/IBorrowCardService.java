package com.example.bai_thi.service;

import com.example.bai_thi.dto.BorrowCardDto;
import com.example.bai_thi.model.BorrowCard;

import java.util.List;

public interface IBorrowCardService {
    boolean addBorrowCard(BorrowCard borrowCard);
    List<BorrowCardDto> getBorrowedBooks(String bookTitle, String studentName);
    boolean returnBook(String borrowId, String bookId);
}
