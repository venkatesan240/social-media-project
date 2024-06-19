package controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dao.PostDAO;
import model.Post;


@WebServlet("/PostServlet")
@MultipartConfig(maxFileSize = 16177215)
public class PostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public PostServlet() {
        super();
    }

	Post post=new Post();
	PostDAO postdao=new PostDAO();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		post.setDescription(request.getParameter("post-content"));
		Part part=request.getPart("post-image");
		post.setUserid(Integer.parseInt(request.getParameter("userid")));
		post.setUsername(request.getParameter("username"));
		InputStream is=null;
		byte[] data = null;
		if(part != null) {
			is=part.getInputStream();
			data=new byte[is.available()];
			is.read(data);
			 is.close();
		}
		
		post.setImage(data);
		try {
			postdao.savePost(post);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}  
		 request.getRequestDispatcher("post.jsp").forward(request, response);
	}

}
