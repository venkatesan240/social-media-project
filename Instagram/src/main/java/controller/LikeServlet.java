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
		BufferedReader reader = request.getReader();
        Gson gson = new Gson();

        try {
            // Parse JSON to LikeRequest object
            LikeRequest likeRequest = gson.fromJson(reader, LikeRequest.class);

            // Extract values from likeRequest
            int userId = likeRequest.getUserId();
            int postId = likeRequest.getPostId();
            boolean isLiked = likeRequest.isLiked();

            // Process like logic using LikeDAO or any other service
            LikeDAO likeDAO = new LikeDAO();
            if (isLiked) {
                likeDAO.addLike(userId, postId);
            } else {
                likeDAO.removeLike(userId, postId);
            }

            int likeCount = likeDAO.getLikeCount(postId);

            // Prepare JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            PrintWriter out = response.getWriter();
            out.print("{\"likeCount\":" + likeCount + "}");
            out.flush();
        } catch (JsonSyntaxException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Bad JSON format
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Other errors
        }
	}
	

}
