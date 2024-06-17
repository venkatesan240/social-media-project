package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;

import dao.LikeDAO;
import model.LikeRequest;


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
		try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int postId = Integer.parseInt(request.getParameter("postId"));
            boolean isLiked = Boolean.parseBoolean(request.getParameter("isLiked"));

            LikeDAO likeDAO = new LikeDAO();
            if (isLiked) {
                likeDAO.addLike(userId, postId);
            } else {
                likeDAO.removeLike(userId, postId);
            }

            // Redirect back to the same page with updated like count
            response.sendRedirect("post.jsp?postId=" + postId);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
	}
}
