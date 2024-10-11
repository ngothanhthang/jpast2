package vn.iostar.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iostar.entity.User;
import vn.iostar.services.IUserService;
import vn.iostar.services.impl.UserService;

import java.io.IOException;

@WebServlet(urlPatterns = {"/register", "/login"})
public class UserController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/register")) {
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        } else if (url.contains("/login")) {
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/register")) {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String email = req.getParameter("email");

            User user = new User();
            user.setUsername(username);
            user.setPassword(password); // Bạn có thể mã hóa mật khẩu ở đây
            user.setEmail(email);

            userService.insert(user);
            resp.sendRedirect(req.getContextPath() + "/login");
        } else if (url.contains("/login")) {
            String username = req.getParameter("username");
            String password = req.getParameter("password");

            User user = userService.login(username, password);
            if (user != null) {
                req.getSession().setAttribute("user", user); // Lưu thông tin người dùng vào session
                resp.sendRedirect(req.getContextPath() + "/admin/categories"); // Chuyển hướng đến trang admin
            } else {
                req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            }
        }
    }
}
