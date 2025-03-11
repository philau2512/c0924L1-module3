<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add new product</title>
</head>
<body>
<h1>Add new product</h1>
<p>
    <c:if test='${requestScope["message"] != null}'>
        <span class="message">${requestScope["message"]}</span>
    </c:if>
</p>
<p>
    <a href="/products">Back to product list</a>
</p>
<form method="post">
    <input type="number" name="id" placeholder="Input ID">
    <input type="text" name="name" placeholder="Input Name">
    <input type="number" name="price" placeholder="Input Price">
    <input type="submit" value="Add New">
</form>
</body>
</html>
