package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;

/**
 * Servlet implementation class ResetPassword
 */
@WebServlet("/resetpassword")
public class ResetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResetPassword() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String  email = request.getParameter("email");
		String  confirmpassword = request.getParameter("confirm-password");
		
		UserDAO userdao=new UserDAO();
		try {
			userdao.updatePassword(confirmpassword, email);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} 
		request.setAttribute("Message","password reset sucessfully");
		 request.getRequestDispatcher("signin.jsp").forward(request, response);

	}

}
