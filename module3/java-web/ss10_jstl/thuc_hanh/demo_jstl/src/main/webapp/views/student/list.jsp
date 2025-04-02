<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <s:import url="../layout/library.jsp"/>
</head>
<body>
<c:import url="../layout/header.jsp"/>
<h1>Danh sách sinh viên</h1>
<a href="/students?action=create">Thêm mới</a>

<form action="/students" method="get" class="d-flex justify-content-end">
    <input hidden="hidden" name="action" value="search">
    <input value="${searchName}" class="form-control form-control-sm w-25" name="searchName"
           placeholder="Nhập tên cần tìm kiếm">
    <select name= "classId" class="form-control form-control-sm w-25" aria-label=".form-select-sm example">
        <option selected value="">---Chọn lớp---</option>
        <c:forEach items="${classList}" var="cls">
            <option value="${cls.getId()}">${cls.getClassName()}</option>
        </c:forEach>
    </select>
    <button class="btn btn-primary btn-sm">Tìm kiếm</button>
</form>

<p>${param.mess}</p>
<table id="tableStudent" class="table table-dark">
    <thead>
    <tr>
        <th>STT</th>
        <th>Name</th>
        <th>Gender</th>
        <th>Score</th>
        <th>Xếp loại</th>
        <th>Mã lớp học</th>
        <th>Xóa</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${studentList}" var="student" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${student.getName()}</td>
            <td>
                <c:if test="${student.isGender()}">
                    <span>Nam</span>
                </c:if>
                <c:if test="${!student.isGender()}">
                    <span>Nữ</span>
                </c:if>
            </td>
            <td>${student.getScore()}</td>
            <td>
                <c:choose>
                    <c:when test="${student.getScore() >= 8}">
                        <span>Giỏi</span>
                    </c:when>
                    <c:when test="${student.getScore() >= 7}">
                        <span>Khá</span>
                    </c:when>
                    <c:when test="${student.getScore() >= 5}">
                        <span>Trung bình</span>
                    </c:when>
                    <c:otherwise>
                        <span>Yếu</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>${student.getClassName()}</td>
            <td>
                <button onclick="thongTinXoa(`${student.getId()}`, `${student.getName()}`)" type="button"
                        class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    Xóa
                </button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<!-- Modal Xoá-->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/students" method="get">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input hidden="hidden" name="action" value="delete">
                    <input hidden="hidden" id="deleteId" name="deleteId">
                    <span>Bạn có muốn xoá sinh viên có tên </span><span id="deleteName"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button type="submit" class="btn btn-primary">Xoá</button>
                </div>
            </div>
        </form>

    </div>
</div>

<script>
    function thongTinXoa(id, name) {
        document.getElementById("deleteId").value = id;
        document.getElementById("deleteName").innerText = name;
    }
</script>
<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="datatables/js/jquery.dataTables.min.js"></script>
<script src="datatables/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function () {
            $(`#tableStudent`).dataTable(
                {
                    "dom": 'lrtip',
                    "lengthChange": false,
                    "pageLength": 5
                }
            )
        }
    )
</script>
</body>
</html>
