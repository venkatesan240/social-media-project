package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.LikeDAO;


@WebServlet("/LikeServlet")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public LikeServlet() {
        super();

    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int userId = Integer.parseInt(request.getParameter("userId"));
	        int postId = Integer.parseInt(request.getParameter("postId"));
	        boolean isLiked = Boolean.parseBoolean(request.getParameter("isLiked"));
	        System.out.println(userId);
	        System.out.println(postId);
	        LikeDAO likeDAO = new LikeDAO();

	        if (isLiked) {
	            try {
					likeDAO.addLike(userId, postId);
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
	        } else {
	            try {
					likeDAO.removeLike(userId, postId);
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
	        }

	        int likeCount = 0;
			try {
				likeCount = likeDAO.getLikeCount(postId);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
	        response.setContentType("application/json");
	        response.getWriter().write("{\"likeCount\":" + likeCount + "}");
	}
	

}
