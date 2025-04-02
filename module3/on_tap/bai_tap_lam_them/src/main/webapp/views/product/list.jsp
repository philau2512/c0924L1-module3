<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <c:import url="../layout/library.jsp"/>
    <style>
        #tableProduct th, #tableProduct td {
            /*text-align: center; căn giữa theo chiều ngang */
            vertical-align: middle; /* căn giữa theo chiều dọc */
        }

        .dataTables_paginate {
            float: right !important;
            margin-top: 10px;
        }

        .dataTables_info {
            float: left !important;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<h1>Quản lý sản phẩm rau củ quả</h1>
<a href="/products?action=create">Thêm sản phẩm mới</a> <%-- Nút thêm sản phẩm mới --%>

<%--Ô tìm kiếm sản phẩm--%>
<form action="/products" method="get" class="d-flex justify-content-end">
    <input hidden="hidden" name="action" value="search">
    <input value="${searchName}" class="form-control form-control-sm w-25" name="searchName"
           placeholder="Nhập tên cần tìm kiếm">
    <select name="categoryId" class="form-control form-control-sm w-25" aria-label=".form-select-sm example">
        <option value="" ${categoryId == '' ? 'selected' : ''}>---Loại hàng hóa---</option>
        <c:forEach items="${categoryList}" var="category">
            <option value="${category.id}" ${category.id == categoryId ? 'selected' : ''}>${category.name}</option>
        </c:forEach>
    </select>
    <button class="btn btn-primary btn-sm">Tìm kiếm</button>
</form>

<table id="tableProduct" class="table table-striped">
    <thead>
    <tr>
        <th>STT</th>
        <th>Mã hàng hóa</th>
        <th>Tên hàng hóa</th>
        <th>Đơn vị tính</th>
        <th>Giá</th>
        <th>Loại hàng hóa</th>
        <th>Chỉnh sửa</th>
        <th>Xóa</th>
    </tr>
    </thead>
    <c:forEach var="product" items="${productList}" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${product.getCode()}</td>
            <td>${product.getName()}</td>
            <td>${product.getUnit()}</td>
            <td>${product.getPricePerUnit()}</td>
            <td>${product.getCategoryName()}</td>
            <td>
                <button onclick="showEditModal('${product.getId()}', '${product.getCode()}', '${product.getName()}', '${product.getUnit()}', '${product.getPricePerUnit()}', '${product.getCategoryId()}')"
                        type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editModal">
                    Chỉnh sửa
                </button>
            </td>
            <td>
                <button onclick="thongTinXoa(`${product.getId()}`, `${product.getName()}`)" type="button"
                        class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    Xóa
                </button>
            </td>
        </tr>
    </c:forEach>
    <tbody>

    </tbody>
</table>
</body>
<!-- Modal Xoá-->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/products" method="get">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Confirm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input hidden="hidden" name="action" value="delete">
                    <input hidden="hidden" id="deleteId" name="deleteId">
                    <span>Bạn có muốn sản phẩm </span><span id="deleteName"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button type="submit" class="btn btn-primary">Xoá</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Modal Thông báo -->
<div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="messageModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="messageModalLabel">Thông báo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <span id="messageContent"
                      class="${param.mess.contains('successful') ? 'text-success' : 'text-danger'}">${param.mess}</span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<!-- Toast Thông báo -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="messageToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto">Thông báo</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            ${param.mess}
        </div>
    </div>
</div>

<!-- Modal Chỉnh sửa -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form id="editProductForm" action="/products" method="post" onsubmit="return validateEditForm()">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Chỉnh sửa sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" id="editId" name="id">

                    <div class="mb-3">
                        <label for="editCode" class="form-label">Mã hàng hóa (NHH-XXX):</label>
                        <input type="text" class="form-control" id="editCode" name="code" required
                               pattern="NHH-[0-9]{3}" placeholder="Ví dụ: NHH-123">
                        <div id="editCodeError" class="error"></div>
                    </div>

                    <div class="mb-3">
                        <label for="editName" class="form-label">Tên hàng hóa:</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                        <div id="editNameError" class="error"></div>
                    </div>

                    <div class="mb-3">
                        <label for="editUnit" class="form-label">Đơn vị tính:</label>
                        <select class="form-control" id="editUnit" name="unit" required>
                            <option value="">-- Chọn đơn vị --</option>
                            <option value="kg">kg</option>
                            <option value="cái">cái</option>
                            <option value="quả">quả</option>
                        </select>
                        <div id="editUnitError" class="error"></div>
                    </div>

                    <div class="mb-3">
                        <label for="editPricePerUnit" class="form-label">Giá (VNĐ):</label>
                        <input type="number" class="form-control" id="editPricePerUnit" name="pricePerUnit" required
                               min="1000" step="1">
                        <div id="editPriceError" class="error"></div>
                    </div>

                    <div class="mb-3">
                        <label for="editCategoryId" class="form-label">Loại hàng hóa:</label>
                        <select class="form-control" id="editCategoryId" name="categoryId" required>
                            <option value="">-- Chọn loại hàng hóa --</option>
                            <c:forEach items="${categoryList}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                        <div id="editCategoryError" class="error"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="datatables/js/jquery.dataTables.min.js"></script>
<script src="datatables/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function () {
            $(`#tableProduct`).dataTable(
                {
                    "dom": 'lrtip',
                    "lengthChange": false,
                    "pageLength": 3,
                    "language": {
                        "info": "Hiển thị _START_-_END_ trong tổng số _TOTAL_ mục",
                        "paginate": {
                            "previous": "Trước",
                            "next": "Tiếp theo"
                        },
                        "emptyTable": "Không có dữ liệu trong bảng",
                        "infoEmpty": "Hiển thị 0 đến 0 trong tổng số 0 mục"
                    }
                }
            )
            // Kiểm tra nếu có thông báo thì hiển thị modal
            const message = "${param.mess}";
            if (message && message.trim() !== "") {
                $('#messageModal').modal('show');
            }

            /* Có thể dùng toasts để hiện thông báo
            if (message && message.trim() !== "") {
                const toast = new bootstrap.Toast(document.getElementById('messageToast'));
                toast.show();
            } */

            // Nếu có dữ liệu sản phẩm (từ action=edit), tự động mở modal chỉnh sửa
            <c:if test="${not empty product}">
            showEditModal(
                '${product.getId()}',
                '${product.getCode()}',
                '${product.getName()}',
                '${product.getUnit()}',
                '${product.getPricePerUnit()}',
                '${product.getCategoryId()}'
            );
            $('#editModal').modal('show');
            </c:if>
        }
    )
</script>
<script>
    function thongTinXoa(id, name) {
        document.getElementById("deleteId").value = id;
        document.getElementById("deleteName").innerText = name;
    }

    function showEditModal(id, code, name, unit, pricePerUnit, categoryId) {
        document.getElementById("editId").value = id;
        document.getElementById("editCode").value = code;
        document.getElementById("editName").value = name;
        document.getElementById("editUnit").value = unit;
        document.getElementById("editPricePerUnit").value = pricePerUnit;
        document.getElementById("editCategoryId").value = categoryId;
    }

    function validateEditForm() {
        let isValid = true;

        // Reset thông báo lỗi
        document.querySelectorAll('.error').forEach(error => error.innerText = '');

        // Validate mã hàng hóa (NHH-XXX)
        const code = document.getElementById('editCode').value;
        const codePattern = /^NHH-[0-9]{3}$/;
        if (!codePattern.test(code)) {
            document.getElementById('editCodeError').innerText = 'Mã hàng hóa phải có định dạng NHH-XXX (X là số)';
            isValid = false;
        }

        // Validate tên hàng hóa
        const name = document.getElementById('editName').value;
        if (!name.trim()) {
            document.getElementById('editNameError').innerText = 'Tên hàng hóa không được để trống';
            isValid = false;
        }

        // Validate đơn vị tính
        const unit = document.getElementById('editUnit').value;
        if (!unit) {
            document.getElementById('editUnitError').innerText = 'Vui lòng chọn đơn vị tính';
            isValid = false;
        }

        // Validate giá
        const price = document.getElementById('editPricePerUnit').value;
        if (price < 1000) {
            document.getElementById('editPriceError').innerText = 'Giá phải là số nguyên dương và >= 1000 VNĐ';
            isValid = false;
        }

        // Validate loại hàng hóa
        const categoryId = document.getElementById('editCategoryId').value;
        if (!categoryId) {
            document.getElementById('editCategoryError').innerText = 'Vui lòng chọn loại hàng hóa';
            isValid = false;
        }

        return isValid;
    }
</script>
</html>
