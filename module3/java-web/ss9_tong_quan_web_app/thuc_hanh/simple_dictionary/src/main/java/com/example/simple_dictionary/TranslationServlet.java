package com.example.simple_dictionary;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "TranslationServlet", value = "/translate")
public class TranslationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, String> dictionary = new HashMap<>();
        dictionary.put("hello", "Xin chào");
        dictionary.put("how", "Thế nào");
        dictionary.put("book", "Quyển vở");
        dictionary.put("computer", "Máy tính");

        String word = req.getParameter("word");

        if (word == null || word.trim().isEmpty()) {
            req.setAttribute("result", "Please enter a word to translate.");
            req.getRequestDispatcher("translate.jsp").forward(req, resp);
            return;  // Dừng lại nếu không có từ để dịch
        }

        String result = dictionary.get(word.toLowerCase());

        req.setAttribute("word", word);
        req.setAttribute("result", (result != null) ? result : "Not found");

        // Chuyển hướng đến trang kết quả
        req.getRequestDispatcher("translate.jsp").forward(req, resp);
    }
}
