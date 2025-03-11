<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Find Product</title>
</head>
<body>
<h1>Result</h1>
<p>
    <a href="/products">Back to product list</a>
</p>
<table border="1" style="border-collapse: collapse">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
    </tr>
    <c:forEach items="${products}" var="product" varStatus="status">
        <tr>
            <td>${product.getId()}</td>
            <td>
                <a href="/products?action=view&id=${product.getId()}">${product.getName()}</a>
            </td>
            <td>${product.getPrice()}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
