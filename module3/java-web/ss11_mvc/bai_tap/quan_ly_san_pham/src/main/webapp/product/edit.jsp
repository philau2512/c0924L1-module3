<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit product</title>
</head>
<body>
<h1>Edit Product</h1>
<p>
    <c:if test='${requestScope["message"] != null}'>
        <span class="message">${requestScope["message"]}</span>
    </c:if>
</p>
<p>
    <a href="/products">Back to customer list</a>
</p>
<form method="post">
    <legend>Product information</legend>
    <table>
        <tr>
            <td>ID:</td>
            <td>
                <input type="number" name="id" value="${requestScope['product'].getId()}">
            </td>
        </tr>
        <tr>
            <td>Name:</td>
            <td>
                <input type="text" name="name" value="${requestScope['product'].getName()}">
            </td>
        </tr>
        <tr>
            <td>Price:</td>
            <td>
                <input type="number" name="price" value="${requestScope['product'].getPrice()}">
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <input type="submit" value="Update Product">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
