package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.MessageDAO;
import dao.UserDAO;
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
	        HttpSession session = request.getSession();
	       
			//System.out.println("send ----> " + senderId);
			//session.setAttribute("userid",senderId);
			
	        //out.print(new Gson().toJson(message));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
		 int senderId = Integer.parseInt(request.getParameter("senderId"));
	        int receiverId = Integer.parseInt(request.getParameter("receiverId"));
	        msg.setSenderId(senderId);
	        msg.setReceiverId(receiverId);
	        Map<String, String> message = null;
			try {
				message = msgdao.getMessage(msg);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			request.setAttribute("message",message);
        String message1 = request.getParameter("message");
       
        //System.out.println("SenderID ---> " + senderId);
        //System.out.println("ReceiverID ---> " + receiverId);
        
        msg.setSenderId(senderId);
        msg.setReceiverId(receiverId);
        msg.setMessage(message1);
        try {
			msgdao.insertMessage(msg);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
        request.getRequestDispatcher("view-message.jsp").forward(request, response);
	}

}
