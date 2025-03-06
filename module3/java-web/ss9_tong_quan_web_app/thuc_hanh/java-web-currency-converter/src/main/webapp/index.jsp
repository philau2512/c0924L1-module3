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

        .convert {
            height: 210px;
            width: 300px;
            margin: 0;
            padding: 10px;
            border: 1px #ccc solid;
        }

        label {
            margin: 10px;
            padding: 10px;
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
<h2>Currency Converter</h2>
<form action="/convert" method="post">
    <div class="convert">
        <label>Rate : </label>
        <br/>
        <input type="text" name="rate" placeholder="RATE" value="22000">
        <br/>
        <label>USD : </label>
        <br/>
        <input type="text" name="usd" placeholder="USD" value="0">
        <br/>
        <button type="submit" id="submit">Convert</button>
    </div>
</form>
</body>

</html>