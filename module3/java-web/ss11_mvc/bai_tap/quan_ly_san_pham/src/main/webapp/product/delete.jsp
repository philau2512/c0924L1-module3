<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Product</title>
</head>
<body>
<h1>Delete Product</h1>
<p>
    <a href="/products">Back to product list</a>
</p>
<form method="post">
    <h3>Are you sure to delete?</h3>
    <table>
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
        <tr>
            <td>
                <input type="submit" value="Delete Product">
            </td>
            <td>
                <a href="/products">Back to product list</a>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
