package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.commentDAO;
import model.Comment;


@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CommentServlet() {
        super();

    }
    Comment comment=new Comment();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int postId = Integer.parseInt(request.getParameter("postid"));
		 int userid = Integer.parseInt(request.getParameter("userid"));
		 String comment1=request.getParameter("comment");
		 comment.setPostid(postId);
		 comment.setUserid(userid);
		 comment.setComment(comment1);
        try {
			commentDAO.addComment(comment);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
        request.getRequestDispatcher("post.jsp").forward(request, response);
        // Send success response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"status\": \"success\"}");
	}

}
