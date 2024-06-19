package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.MessageDAO;

@WebServlet("/userlistservlet")
public class Userlistservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 MessageDAO msgdao=new MessageDAO();
    public Userlistservlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, String>> users = null;
        try {
            users = msgdao.selectUsers(); // Ensure this method returns a List<Map<String, String>>
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        request.setAttribute("users", users);
        request.getRequestDispatcher("chat.jsp").forward(request, response);
        
    }



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
