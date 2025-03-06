<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <title>Currency Converter</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
        }

        form {
            text-align: center;
            margin: 0 auto;
            width: 300px;
            padding: 10px;
            justify-content: space-between;
        }

        input {
            margin: 10px;
            padding: 10px;
            align-items: center;
        }

        button {
            margin: 10px;
            padding: 10px;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>

<body>
<h2>Vietnamese Dictionary</h2>
<form action="/translate" method="post">
    <div class="translate">
        <input type="text" name="word" placeholder="Enter your word: " />
        <button type="submit" id="submit">Search</button>
    </div>
</form>
</body>
</html>