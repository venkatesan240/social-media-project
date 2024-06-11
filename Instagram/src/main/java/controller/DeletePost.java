package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PostDAO;

/**
 * Servlet implementation class DeletePost
 */
@WebServlet("/deletePost")
public class DeletePost extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeletePost() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String postId = request.getParameter("id");
		// System.out.println("print");
	        if (postId != null) {
	        	//System.out.println("Received request to delete post with ID: " + postId);
	            PostDAO postDAO = new PostDAO();
	            boolean deleted = false;
				try {
					deleted = postDAO.deletePost(Integer.parseInt(postId));
				} catch (NumberFormatException | ClassNotFoundException e) {
					e.printStackTrace();
				} 
	            if (deleted) {
	            	 request.getRequestDispatcher("post.jsp").forward(request, response);
	            } else {
	                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	            }
	        } else {
	            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
