package com.example.online_electronics_store.controller;

import com.example.online_electronics_store.model.User;
import com.example.online_electronics_store.service.impl.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UserServlet", value = "/user")
public class UserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        controller(request, response);
    }

    private void controller(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "admin":
                    toAdmin(request, response);
                    break;
                case "account":
                    toAccount(request, response);
                    break;
                case "register":
                    register(request, response);
                    break;
                case "login":
                    login(request, response);
                    break;
                case "update":
                    // update
                    break;
                case "view":
                    break;
                default:
                    toLoginPage(response);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        controller(request, response);
    }

    private void toLoginPage(HttpServletResponse response) throws IOException {
        response.sendRedirect("http://localhost:8080/shop/login-register.jsp");
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, SQLException, IOException {
        if (UserService.getInstance().create(request)) {
            request.setAttribute("regMess", "Register successfully");
            RequestDispatcher dispatcher = request.getRequestDispatcher("shop/login-register.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("regMess", "Username / Email / Phone number exist");
            RequestDispatcher dispatcher = request.getRequestDispatcher("shop/login-register.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, SQLException, IOException {
        User user = UserService.getInstance().loginCheck(request);
        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            if (user.getRole().equals("user")) {
                response.sendRedirect("/product");
            } else if (user.getRole().equals("admin")) {
                toAdmin(request, response);
            }

        } else {
            request.setAttribute("logMess", "Wrong username / email or password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("http://localhost:8080/shop/login-register.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void toAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.sendRedirect("/product?action=display_admin");
    }

    private void toAccount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect("shop/my-account.jsp");
    }
}
