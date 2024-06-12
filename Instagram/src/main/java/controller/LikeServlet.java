package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

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
        System.out.println("userid"+userId);
        System.out.println("postId"+postId);
        System.out.println("isLiked"+isLiked);
        LikeDAO likeDAO = new LikeDAO();

        try {
            if (isLiked) {
                likeDAO.addLike(userId, postId);
            } else {
                likeDAO.removeLike(userId, postId);
            }

            int likeCount = likeDAO.getLikeCount(postId);
            System.out.println("likecount"+likeCount);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("likeCount", likeCount);

            PrintWriter out = response.getWriter();
            out.print(jsonResponse.toString());
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }

	}
	

}
