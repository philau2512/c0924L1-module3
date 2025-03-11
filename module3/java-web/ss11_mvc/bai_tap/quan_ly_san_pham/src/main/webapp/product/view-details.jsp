<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Product Details</title>
</head>
<body>
<h1>Product details</h1>
<p>
    <a href="/products">Back to product list</a>
</p>
<table border="1" style="border-collapse: collapse">
    <tr>
        <td>ID:</td>
        <td>${requestScope['product'].getId()}</td>
    </tr>
    <tr>
        <td>Name:</td>
        <td>${requestScope['product'].getName()}</td>
    </tr>
    <tr>
        <td>Price:</td>
        <td>${requestScope['product'].getPrice()}</td>
    </tr>
</table>
</body>
</html>
