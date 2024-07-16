package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;


@WebServlet("/signin")
public class SignIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SignIn() {
        super();
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		User user=new User();
		user.setEmail(email);
		user.setPassword(password);
		UserDAO user1=new UserDAO();
		boolean logincredencial = false;
		try {
			logincredencial = user1.logincredencial(user);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Internal error. Please try again later.");
            request.getRequestDispatcher("signin.jsp").forward(request, response);
            return;
		}
		
		if(logincredencial) {
			HttpSession session=request.getSession();
			session.setAttribute("email",email);
			String name = null;
			int userid;
			try {
				name = user1.getName(email);
				userid=user1.getId(email);
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
				 request.setAttribute("errorMessage", "Internal error. Please try again later.");
	                request.getRequestDispatcher("signin.jsp").forward(request, response);
	                return;
			}
			session.setAttribute("name", name);
			session.setAttribute("userid",userid);
			request.getRequestDispatcher("home.jsp").forward(request, response);
		}else {
			request.setAttribute("errorMessage", "Invalid username or password");
			 request.getRequestDispatcher("signin.jsp").forward(request, response);
		}
	}

}
