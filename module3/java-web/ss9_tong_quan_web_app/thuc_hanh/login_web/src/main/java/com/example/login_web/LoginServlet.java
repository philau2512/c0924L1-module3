package com.example.login_web;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet (name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        req.setAttribute("username", username);
        req.setAttribute("password", password);

        if (username != null && password != null) {
            if ("admin".equals(username) && "admin".equals(password)) {
                String result = "Welcome " + username + " to the website!";
                req.setAttribute("result", result);
            } else {
                String result = "Login Error: Invalid credentials.";
                req.setAttribute("result", result);
            }
        }
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}
