<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.ArrayList"%>
<%@ page import="model.Message"%>
<%@ page import="dao.UserDAO"%>
<%@ page import="dao.MessageDAO" %>
<%
int senderId = Integer.parseInt(session.getAttribute("userid").toString());
int receiverId = Integer.parseInt(request.getParameter("receiverId"));
//System.out.println(receiverId);
MessageDAO msgdao = new MessageDAO();
Message msg = new Message();
msg.setSenderId(senderId);
msg.setReceiverId(receiverId);
ArrayList<Message> messages = new ArrayList<>();
try {
	messages = msgdao.getMessage(msg);
} catch (ClassNotFoundException e) {
	e.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
<div class="container">
    <%
        if (messages != null && messages.size() == 0) {
    %>
            <h4 style="text-align: center; color: #ffffff;">No Messages.</h4>
    <%
        }

        if (messages != null) {
            for (Message message : messages) {
                String currentUserId = String.valueOf(message.getSenderId());
                System.out.println(message.getSenderId());
                if (currentUserId.equals(session.getAttribute("userid"))) {
    %>
                    <div class="row justify-content-end">
                        <div class="col-8 alert alert-primary" role="alert">
                            <h5>
                                me <a href="${pageContext.request.contextPath}/view-message?id=<%= senderId %>&delete=<%= message.getId() %>" class="card-link" style="float: right;"><i style="color: red;" class="far fa-trash-alt"></i></a>
                            </h5>
                            <%= message.getSenderId() %>
                            <%= message.getMessage() %>
                            <p style="text-align: right;"><%= message.getTimestamp() %></p>
                        </div>
                    </div>
    <%
                } else {
    %>
                    <div class="row justify-content-start">
                        <div class="col-8 alert alert-secondary" role="alert">
                            <h5>
                                <%= new UserDAO().getUserById(message.getReceiverId()).getFirst_name() %> <a href="${pageContext.request.contextPath}/view-message?id=<%= request.getAttribute("receiverId") %>&delete=<%= message.getId() %>" class="card-link" style="float: right;"><i style="color: red;" class="far fa-trash-alt"></i></a>
                            </h5>
                            <%= message.getReceiverId() %>
                            <%= message.getMessage() %>
                            <p style="text-align: right;"><%= message.getTimestamp() %></p>
                        </div>
                    </div>
    <%
                }
            }
        }
    %>
</div>

<div class="type_msg">
    <form method="post" action="ChatServlet">
        <div class="input_msg_write d-flex">
            <input type="hidden" name="senderId" value="<%= session.getAttribute("userid") %>" />
            <input type="hidden" name="receiverId" value="<%= receiverId %>" />
            <input type="text" name="message" class="write_msg" placeholder="Type a message" required />
            <button class="msg_send_btn ml-2" type="submit">
                <i class="fa-solid fa-paper-plane"></i>
            </button>
        </div>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>