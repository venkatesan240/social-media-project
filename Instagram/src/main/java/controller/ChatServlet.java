package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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


    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("application/json");
	        if(request.getParameter("delete") != null) {
	        	int id=Integer.parseInt(request.getParameter("delete"));
				try {
					msgdao.deleteMessage(id);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
	        request.getRequestDispatcher("viewmessage.jsp").forward(request, response);

	}
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int senderId = Integer.parseInt(request.getParameter("senderId"));
	        int receiverId = Integer.parseInt(request.getParameter("receiverId"));
	        msg.setSenderId(senderId);
	        msg.setReceiverId(receiverId);
	        ArrayList<Message> messages = new ArrayList<>();
			try {
				messages = msgdao.getMessage(msg);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			request.setAttribute("messages",messages);
        String message1 = request.getParameter("message");
        msg.setSenderId(senderId);
        msg.setReceiverId(receiverId);
        msg.setMessage(message1);
        try {
			msgdao.insertMessage(msg);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
        request.getRequestDispatcher("viewmessage.jsp").forward(request, response);
	}

}
