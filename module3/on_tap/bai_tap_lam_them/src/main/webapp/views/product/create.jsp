<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thêm sản phẩm mới</title>
    <c:import url="../layout/library.jsp"/>
    <style>
        .error {
            color: red;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
<h1>Thêm sản phẩm mới</h1>
<a href="/products">Quay lại danh sách</a>

<form id="createProductForm" action="/products" method="POST" onsubmit="return validateForm()">
    <input type="hidden" name="action" value="create">

    <div class="mb-3">
        <label for="code" class="form-label">Mã hàng hóa (NHH-XXX):</label>
        <input type="text" class="form-control" id="code" name="code" required
               pattern="NHH-[0-9]{3}" placeholder="Ví dụ: NHH-123">
        <div id="codeError" class="error"></div>
    </div>

    <div class="mb-3">
        <label for="name" class="form-label">Tên hàng hóa:</label>
        <input type="text" class="form-control" id="name" name="name" required>
        <div id="nameError" class="error"></div>
    </div>

    <div class="mb-3">
        <label for="unit" class="form-label">Đơn vị tính:</label>
        <select class="form-control" id="unit" name="unit" required>
            <option value="">-- Chọn đơn vị --</option>
            <option value="kg">kg</option>
            <option value="cái">cái</option>
            <option value="quả">quả</option>
        </select>
        <div id="unitError" class="error"></div>
    </div>

    <div class="mb-3">
        <label for="pricePerUnit" class="form-label">Giá (VNĐ):</label>
        <input type="number" class="form-control" id="pricePerUnit" name="pricePerUnit" required
               min="1000" step="1">
        <div id="priceError" class="error"></div>
    </div>

    <div class="mb-3">
        <label for="categoryId" class="form-label">Loại hàng hóa:</label>
        <select class="form-control" id="categoryId" name="categoryId" required>
            <option value="">-- Chọn loại hàng hóa --</option>
            <c:forEach items="${categoryList}" var="category">
                <option value="${category.id}">${category.name}</option>
            </c:forEach>
        </select>
        <div id="categoryError" class="error"></div>
    </div>

    <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
</form>
<script>
    function validateForm() {
        let isValid = true;

        // Reset thông báo lỗi
        document.querySelectorAll('.error').forEach(error => error.innerText = '');

        // Validate mã hàng hóa (MHH-XXXX)
        const code = document.getElementById('code').value;
        const codePattern = /^NHH-[0-9]{3}$/;
        if (!codePattern.test(code)) {
            document.getElementById('codeError').innerText = 'Mã hàng hóa phải có định dạng MHH-XXXX (X là số hoặc chữ in hoa)';
            isValid = false;
        }

        // Validate tên hàng hóa
        const name = document.getElementById('name').value;
        if (!name.trim()) {
            document.getElementById('nameError').innerText = 'Tên hàng hóa không được để trống';
            isValid = false;
        }

        // Validate đơn vị tính
        const unit = document.getElementById('unit').value;
        if (!unit) {
            document.getElementById('unitError').innerText = 'Vui lòng chọn đơn vị tính';
            isValid = false;
        }

        // Validate giá
        const price = document.getElementById('pricePerUnit').value;
        if (price < 1000) {
            document.getElementById('priceError').innerText = 'Giá phải là số nguyên dương và >= 1000 VNĐ';
            isValid = false;
        }

        // Validate loại hàng hóa
        const categoryId = document.getElementById('categoryId').value;
        if (!categoryId) {
            document.getElementById('categoryError').innerText = 'Vui lòng chọn loại hàng hóa';
            isValid = false;
        }

        return isValid;
    }
</script>
</body>
</html>
