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
<style>
.type_msg {
    padding: 20px;
    background-color: #f6f6f6;
}

.input_msg_write {
    width: 100%;
    position: relative;
}

.input_msg_write input[type="text"] {
    width: calc(100% - 40px); /* Adjust the width as needed */
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    outline: none;
}

.input_msg_write button {
    position: absolute;
    right: 0;
    top: 0;
    width: 40px;
    height: 100%;
    border: none;
    background-color: transparent;
    cursor: pointer;
}

.input_msg_write button i {
    font-size: 20px;
    color: #007bff; /* Adjust the color as needed */
}

.input_msg_write button:hover i {
    color: #0056b3; /* Adjust the hover color as needed */
}

</style>
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
                if (currentUserId.equals(session.getAttribute("userid").toString())) {
    %>
                    <div class="row justify-content-end">
                        <div class="col-8 alert alert-primary" role="alert">
                            <h5>
                                me <a href="${pageContext.request.contextPath}/view-message?id=<%= senderId %>&delete=<%= message.getId() %>" class="card-link" style="float: right;"><i style="color: red;" class="far fa-trash-alt"></i></a>
                            </h5>
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