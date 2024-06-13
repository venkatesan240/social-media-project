package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.commentDAO;
import model.Comment;


@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CommentServlet() {
        super();

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int postId = Integer.parseInt(request.getParameter("postId"));
		 int userid = Integer.parseInt(request.getParameter("userid"));
	        List<Comment> comments = null;
			try {
				comments = commentDAO.getCommentsByPostId(postId);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}

	        // Convert comments to HTML or JSON response and send back to client
	        // Example: write JSON response
	        Gson gson = new Gson();
	        String json = gson.toJson(comments);

	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(json);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        String jsonString = sb.toString();
        Gson gson = new Gson();
        Comment comment = gson.fromJson(jsonString, Comment.class);

        // Set timestamp for the new comment

        // Add comment using DAO
        try {
			commentDAO.addComment(comment);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

        // Send success response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"status\": \"success\"}");
	}

}
