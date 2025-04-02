<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Sách đang mượn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
    <h2 class="mt-4" style="text-align: center; margin-bottom: 20px">Thống kê sách đang cho mượn</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <form method="get" action="/borrowed" class="mb-3">
        <div class="row">
            <div class="col">
                <input type="text" class="form-control" name="bookTitle" placeholder="Tìm theo tên sách">
            </div>
            <div class="col">
                <input type="text" class="form-control" name="studentName" placeholder="Tìm theo tên học sinh">
            </div>
            <div class="col">
                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            </div>
        </div>
    </form>
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>Mã mượn sách</th>
            <th>Tên sách</th>
            <th>Tên học sinh</th>
            <th>Ngày mượn</th>
            <th>Ngày trả dự kiến</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="borrowCard" items="${borrowedBooks}">
            <tr>
                <td>${borrowCard.borrowId}</td>
                <td>${borrowCard.bookTitle}</td>
                <td>${borrowCard.studentName}</td>
                <td>${borrowCard.borrowDate}</td>
                <td>${borrowCard.returnDate}</td>
                <td>
                    <!-- Nút "Trả sách" mở modal -->
                    <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#confirmReturnModal"
                            data-borrow-id="${borrowCard.borrowId}" data-book-id="${borrowCard.bookId}"
                            data-student-name="${borrowCard.studentName}" data-book-title="${borrowCard.bookTitle}">
                        Trả sách
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <a href="/book" class="btn btn-secondary">Quay lại danh sách sách</a>
</div>

<!-- Modal xác nhận trả sách -->
<div class="modal fade" id="confirmReturnModal" tabindex="-1" aria-labelledby="confirmReturnModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmReturnModalLabel">Xác nhận trả sách</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <span id="confirmMessage"></span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form method="post" action="/borrowed" id="returnBookForm">
                    <input type="hidden" name="borrowId" id="modalBorrowId">
                    <input type="hidden" name="bookId" id="modalBookId">
                    <button type="submit" class="btn btn-danger">Xác nhận</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Script để truyền thông tin vào modal
    document.addEventListener('DOMContentLoaded', function () {
        var confirmReturnModal = document.getElementById('confirmReturnModal');
        confirmReturnModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget; // Nút "Trả sách" đã được nhấn
            var borrowId = button.getAttribute('data-borrow-id');
            var bookId = button.getAttribute('data-book-id');
            var studentName = button.getAttribute('data-student-name');
            var bookTitle = button.getAttribute('data-book-title');

            // Gán giá trị vào form trong modal
            var modalBorrowId = document.getElementById('modalBorrowId');
            var modalBookId = document.getElementById('modalBookId');
            modalBorrowId.value = borrowId;
            modalBookId.value = bookId;

            // Cập nhật thông điệp trong modal
            var confirmMessage = document.getElementById('confirmMessage');
            confirmMessage.innerHTML = 'Bạn <strong>' + studentName + '</strong> muốn trả sách <strong>' + bookTitle + '</strong>?';
        });
    });
</script>
</body>
</html>