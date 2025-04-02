<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<html>
<head>
    <title>Mượn sách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h2 class="mt-4" style="text-align: center; margin-bottom: 20px">Mượn sách</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <form method="post" action="/borrow">
        <input type="hidden" name="bookId" value="${book.bookId}">
        <div class="mb-3">
            <label for="borrowId" class="form-label">Mã mượn sách (MS-XXXX):</label>
            <input type="text" class="form-control" id="borrowId" name="borrowId" required pattern="MS-\d{4}"
                   placeholder="MS-1234">
        </div>
        <div class="mb-3">
            <label for="bookTitle" class="form-label">Tên sách:</label>
            <input type="text" class="form-control" id="bookTitle" value="${book.bookTitle}" readonly>
        </div>
        <div class="mb-3">
            <label for="studentId" class="form-label">Tên học sinh:</label>
            <select class="form-select" id="studentId" name="studentId" required>
                <c:forEach var="student" items="${studentList}">
                    <option value="${student.studentId}">${student.studentName} - ${student.className}</option>
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <label for="borrowDate" class="form-label">Ngày mượn:</label>
            <input type="text" class="form-control" id="borrowDate"
                   value="<%= new SimpleDateFormat("dd/MM/yyyy").format(new Date()) %>" readonly>
        </div>
        <div class="mb-3">
            <label for="returnDate" class="form-label">Ngày trả:</label>
            <input type="text" class="form-control" id="returnDate" name="returnDate" required placeholder="dd/MM/yyyy">
        </div>
        <button type="submit" class="btn btn-success">Mượn sách</button>
        <a href="/book" class="btn btn-secondary">Trở về danh sách</a>
    </form>
</div>
</body>
</html>