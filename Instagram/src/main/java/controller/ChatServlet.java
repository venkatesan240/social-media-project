package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.MessageDAO;
import model.Message;


@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 MessageDAO msgdao=new MessageDAO();
     Message msg=new Message();

    public ChatServlet() {
        super();
     
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("application/json");
	        PrintWriter out = response.getWriter();

	        int senderId = Integer.parseInt(request.getParameter("senderId"));
	        int receiverId = Integer.parseInt(request.getParameter("reciverId"));
	        msg.setSenderId(senderId);
	        msg.setReceiverId(receiverId);
	        Map<String, String> message = null;
			try {
				message = msgdao.getMessage(msg);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
	        out.print(new Gson().toJson(message));
	        
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int senderId = Integer.parseInt(request.getParameter("senderId"));
        int receiverId = Integer.parseInt(request.getParameter("reciverId"));
        String message = request.getParameter("message");
        
       
        msg.setSenderId(senderId);
        msg.setReceiverId(receiverId);
        msg.setMessage(message);
        try {
			msgdao.insertMessage(msg);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
