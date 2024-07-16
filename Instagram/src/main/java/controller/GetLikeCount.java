package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.LikeDAO;
import model.User;

/**
 * Servlet implementation class GetLikeCount
 */
@WebServlet("/GetLikes")
public class GetLikeCount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private LikeDAO likeDAO;

    public void init() {
        likeDAO = new LikeDAO();
    }
    public GetLikeCount() {
        super();

    }

	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String postIdStr = request.getParameter("postId");
	        int postId;

	        try {
	            postId = Integer.parseInt(postIdStr);
	        } catch (NumberFormatException e) {
	            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post ID");
	            return;
	        }

	        List<User> users = null;
			try {
				users = likeDAO.getUsersWhoLiked(postId);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}

			request.setAttribute("users", users);
	        request.getRequestDispatcher("post.jsp").forward(request, response);
	    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
