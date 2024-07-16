package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;

/**
 * Servlet implementation class signup
 */
@WebServlet("/signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Signup() {
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
		String firstname = request.getParameter("first-name");
		String  lastname = request.getParameter("last-name");
		String  email = request.getParameter("email");
		String password = request.getParameter("password");
		System.out.println(firstname);
		
		boolean status = true;
		request.removeAttribute("fmsg");
		request.removeAttribute("lmsg");
		request.removeAttribute("emsg");
		request.removeAttribute("pmsg");
		request.removeAttribute("cpmsg");
		request.removeAttribute("rmsg");
		
		if (firstname == null || firstname.equals("")) {
		    request.setAttribute("error", "First name is required ");
		    status = false;
		}
		if (lastname == null || lastname.equals("")) {
		    request.setAttribute("error", "Last name is required ");
		    status = false;
		}
		if (email == null || email.equals("")) {
		    request.setAttribute("error", "Email is required ");
		    status = false;
		}
		if (password == null || password.equals("")) {
		    request.setAttribute("error", "Password is required ");
		    status = false;
		}
		if (password == null || password.equals("")) {
		    request.setAttribute("error", "Password is required ");
		    status = false;
		} else if (!password.equals(password)) {
		    request.setAttribute("error", "Password is not matched ");
		    status = false;
		}
		if(!status) {
			request.getRequestDispatcher("signup.jsp").forward(request, response);
		} else {
			User user = new User();
			user.setPassword(password);
			user.setFirstName(firstname);
			user.setEmail(email);
			user.setLastName(lastname);
			String result = null;
			try {
				result = UserDAO.register(user);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			if(result.equals("Registration Successful.")) {
				request.setAttribute("rmsg", result);
				request.getRequestDispatcher("signin.jsp").forward(request, response);
			}else {
				request.setAttribute("error","User already exists");
				request.getRequestDispatcher("signup.jsp").forward(request, response);
			}
			

		}
		
	}

}
