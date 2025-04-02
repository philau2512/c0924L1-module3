package com.example.bai_thi.dto;

import java.util.Date;

public class BorrowCardDto {
    private String borrowId;
    private String bookId;
    private int studentId;
    private boolean status;
    private Date borrowDate;
    private Date returnDate;
    private String bookTitle; // Tên sách
    private String studentName; // Tên học sinh

    public BorrowCardDto() {
    }

    public BorrowCardDto(String borrowId, String bookId, int studentId, boolean status, Date borrowDate, Date returnDate, String bookTitle, String studentName) {
        this.borrowId = borrowId;
        this.bookId = bookId;
        this.studentId = studentId;
        this.status = status;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.bookTitle = bookTitle;
        this.studentName = studentName;
    }

    // Getters và Setters
    public String getBorrowId() {
        return borrowId;
    }

    public void setBorrowId(String borrowId) {
        this.borrowId = borrowId;
    }

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
}