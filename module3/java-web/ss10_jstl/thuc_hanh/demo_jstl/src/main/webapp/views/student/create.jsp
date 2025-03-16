<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 3/10/2025
  Time: 20:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <c:import url="../layout/labrary.jsp"/>
    <style>
        input, button, select {
            margin-top: 10px;
        }

        .form {
            margin-top: 20px;
            width: 300px;
            background-color: lightgrey;
            margin-left: 500px;
            display: flex;
            justify-content: center;
            padding-bottom: 20px;
        }

        h1 {
            text-align: center;
        }

        button {
            background-color: green;
            margin-left: 50px;
        }
    </style>
</head>
<body>
<h1>Thêm mới</h1>
<form action="/students?action=create" method="post">
    <input name="id" placeholder="nhập id">
    <input name="name" placeholder="nhập tên">
    <input type="radio" name="gender" value="true">Nam
    <input type="radio" name="gender" value="false">Nữ
    <input type="number" name="score" placeholder="nhập điểm">
    <select name="classId">
        <option value="0">--chon lớp---</option>
        <option value="1">C05</option>
        <option value="2">C06</option>
        <option value="3">C07</option>
    </select>
    <button>Lưu</button>
</form>
</body>
</html>
