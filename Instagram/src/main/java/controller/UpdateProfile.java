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

/**
 * Servlet implementation class UpdateProfile
 */
@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("email") == null) {
	        response.sendRedirect("signin.jsp");
	        return;
	    }
	    String email = (String) session.getAttribute("email");
	    if (email == null) {
	        response.sendRedirect("signin.jsp");
	        return;
	    } 
	    System.out.println(email);
		String  fname = request.getParameter("first-name");
		String  lname = request.getParameter("last-name");
		String  email1 = request.getParameter("email");
		String  password = request.getParameter("password");
		String  cpassword = request.getParameter("confirm-password");
		User user=new User();
		user.setFirst_name(fname);
		user.setLast_name(lname);
		user.setEmail(email1);
		user.setPassword(password);
		user.setConfirmpassword(cpassword);
		UserDAO userdao=new UserDAO();
		try {
			userdao.updateUser(user,email1);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		session.setAttribute("updateMessage", "Profile updated successfully");
		 request.getRequestDispatcher("header.jsp").forward(request, response);
	}

}
