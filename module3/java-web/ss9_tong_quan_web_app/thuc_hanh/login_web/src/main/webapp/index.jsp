<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<style type="text/css">
    form {
        text-align: center;
        margin: 0 auto;
        width: 300px;
        padding: 10px;
        justify-content: space-between;
    }
    .login {
        height: 210px;
        width: 300px;
        margin: 0;
        padding: 10px;
        border: 1px #ccc solid;
    }
    .login input {
        padding: 5px;
        margin: 5px;
    }
</style>
<body>
<form action="/login" method="post">
    <div class="login">
        <h2>Login</h2>
        <input type="text" name="username" placeholder="Username" size="30"/>
        <input type="password" name="password" placeholder="Password" size="30"/>
        <input type="submit" value="Sign in"/>
    </div>
</form>
</body>
</html>