package controller;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

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
		StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String requestBody = sb.toString();        
        JsonObject jsonObject = JsonParser.parseString(requestBody).getAsJsonObject();
        int postId = jsonObject.get("postId").getAsInt();
        int userId = jsonObject.get("userId").getAsInt();
        LikeDAO likeDAO = new LikeDAO();
        boolean liked = false;
        int likeCount = 0;

        try {
            try {
				if (likeDAO.isLikedByUser(postId, userId)) {
				    likeDAO.removeLike(postId, userId);
				} else {
				    likeDAO.addLike(userId,postId);
				    liked = true;
				}
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
            try {
				likeCount = likeDAO.getLikeCount(postId);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
            
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("liked", liked);
            jsonResponse.addProperty("likeCount", likeCount);
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());

        } catch (SQLException e) {
            e.printStackTrace();
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", false);
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
        }
	}
}
