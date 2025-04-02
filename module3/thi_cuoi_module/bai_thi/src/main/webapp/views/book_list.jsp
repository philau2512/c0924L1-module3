<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách sách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
    <h2 class="mt-4" style="text-align: center; margin-bottom: 20px">Danh sách sách trong thư viện</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <table class="table table-bordered mt-3 table-striped">
        <thead>
        <tr>
            <th>Mã sách</th>
            <th>Tên sách</th>
            <th>Tác giả</th>
            <th>Mô tả</th>
            <th>Số lượng</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="book" items="${bookList}">
            <tr>
                <td>${book.bookId}</td>
                <td>${book.bookTitle}</td>
                <td>${book.bookAuthor}</td>
                <td>${book.description}</td>
                <td>${book.quantity}</td>
                <td>
                    <a href="/book?action=borrow&bookId=${book.bookId}" class="btn btn-primary btn-sm">Mượn</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <a href="/borrowed" class="btn btn-secondary">Xem sách đang mượn</a>
</div>

<!-- Modal thông báo mượn sách thành công -->
<div class="modal fade" id="successBorrowModal" tabindex="-1" aria-labelledby="successBorrowModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successBorrowModalLabel">Thông báo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn <strong>${studentName}</strong> mượn sách thành công!
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script>
    // Hiển thị modal nếu mượn sách thành công
    document.addEventListener('DOMContentLoaded', function () {
        <c:if test="${success}">
        var successBorrowModal = new bootstrap.Modal(document.getElementById('successBorrowModal'));
        successBorrowModal.show();
        </c:if>
    });
</script>
</body>
</html>