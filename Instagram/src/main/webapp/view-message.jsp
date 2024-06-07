<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.User" %>

<%
    List<Map<String, String>> messages = (List<Map<String, String>>) request.getAttribute("message");
	String currentUserId = session.getAttribute("userid") != null ? session.getAttribute("userid").toString() : "";
    String toUserId = request.getParameter("receiverId");
    UserDAO userDAO = new UserDAO();
    System.out.println("messages :"+messages);
%>
<%
    String receiverId = request.getParameter("receiverId");
	System.out.println("receiverId :"+receiverId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .chat-container {
            max-height: 70vh;
            overflow-y: auto;
        }
        .type_msg {
            position: fixed;
            bottom: 0;
            width: 100%;
            background: #f1f1f1;
            padding: 10px 20px;
        }
        .write_msg {
            width: 85%;
            padding: 10px;
            border-radius: 20px;
            border: 1px solid #ccc;
            outline: none;
        }
        .msg_send_btn {
            width: 10%;
            border: none;
            background: #007bff;
            color: white;
            border-radius: 50%;
            outline: none;
        }
        .msg_send_btn {
    width: 50px; /* Width of the button */
    height: 50px; /* Height of the button */
    border: none; /* Remove the border */
    background: #007bff; /* Background color */
    color: white; /* Text color */
    border-radius: 50%; /* Make the button circular */
    outline: none; /* Remove the outline */
    display: flex; /* Use flexbox for alignment */
    justify-content: center; /* Center horizontally */
    align-items: center; /* Center vertically */
    cursor: pointer; /* Change cursor to pointer */
    transition: background 0.3s; /* Smooth background color transition */
}

.msg_send_btn:hover {
    background: #0056b3; /* Darken the background on hover */
}

.msg_send_btn i {
    font-size: 20px; /* Font size of the icon */
}
    </style>
</head>
<body>

<div class="container mt-3 chat-container">
    <% if (messages == null || messages.isEmpty()) { %>
        <h4 style="text-align: center; color: #000;">No Messages.</h4>
    <% } else { %>
        <% for (Map<String, String> message : messages) { 
            boolean isCurrentUserSender = message.get("senderId").equals(currentUserId);
            String senderName = "me";
            if (!isCurrentUserSender) {
                User user = userDAO.getUserById(Integer.parseInt(message.get("senderId")));
                senderName = (user != null) ? user.getFirst_name() : "Unknown";
            }
        %>
            <div class="row justify-content-<%= isCurrentUserSender ? "end" : "start" %> mb-2">
                <div class="col-8 alert alert-<%= isCurrentUserSender ? "primary" : "secondary" %>" role="alert">
                    <h5>
                        <%= senderName %>
                        <a href="<%= request.getContextPath() %>/view-message?id=<%= toUserId %>&delete=<%= message.get("id") %>" class="card-link" style="float: right;">
                            <i class="far fa-trash-alt" style="color: red;"></i>
                        </a>
                    </h5>
                    <p><%= message.get("message") %></p>
                    <p style="text-align: right; font-size: 0.8em; color: #555;"><%= message.get("timestamp") %></p>
                </div>
            </div>
        <% } %>
    <% } %>
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

</body>
</html>
