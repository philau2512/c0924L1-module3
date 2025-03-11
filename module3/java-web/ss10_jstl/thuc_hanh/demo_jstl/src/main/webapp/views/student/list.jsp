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
<p>${param.mess}</p>
<table class="table table-striped">
    <tr>
        <th>STT</th>
        <th>Name</th>
        <th>Gender</th>
        <th>Score</th>
        <th>Xếp loại</th>
        <th>ClassId</th>
    </tr>
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
            <td>${student.getClassId()}</td>
        </tr>
    </c:forEach>

</table>
</body>
</html>
