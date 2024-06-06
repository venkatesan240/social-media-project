<!DOCTYPE html>
<html lang="en">
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat Application</title>
       <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"> 
    <style>
        .friend-list, .chat-container {
            border: 1px solid #ccc;
            padding: 10px;
            margin: 10px;
            border-radius: 5px;
        }
        .message-input {
            display: flex;
        }
        .message-input input {
            flex: 1;
            padding: 5px;
        }
        /* Ensure the modal body has appropriate scrolling behavior */
.modal-body {
    overflow-y: scroll;
    max-height: 350px;
    padding: 10px;
    background-color: #f8f9fa;
    border-radius: 5px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Style for each card element representing a chat user */
.card {
    cursor: pointer;
    margin: 5px 0;
    padding: 10px 15px;
    background-color: #ffffff;
    border: 1px solid #dee2e6;
    border-radius: 5px;
    transition: box-shadow 0.3s, transform 0.3s;
    display: flex;
    align-items: center;
}

/* Card hover effects */
.card:hover {
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    transform: translateY(-2px);
}

/* Style for the card body, adjusting to display user info */
.card-body {
    flex: 1;
    font-size: 16px;
    color: #333;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

/* Style for the paper plane icon */
.card-body .fas.fa-paper-plane {
    color: #007bff;
    font-size: 18px;
}

/* Add some margin to the icon */
.card-body .fas.fa-paper-plane {
    margin-left: 10px;
}

/* User name text */
.card-body span {
    font-weight: bold;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .modal-body {
        max-height: 300px;
    }

    .card-body {
        font-size: 14px;
    }

    .card-body .fas.fa-paper-plane {
        font-size: 16px;
    }
}
        
    </style>
</head>
<body>
<%@include file="header.jsp" %>
    <div class="friend-list" id="friend-list">
        <h2>chat with friends</h2>
    <div class="modal-body" style="overflow-y: scroll; max-height: 350px;">
    <%
        List<Map<String, String>> users = (List<Map<String, String>>) request.getAttribute("users");
        if (users != null) {
           // out.println("Users list size: " + users.size() + "<br>"); // Debugging output
            for (Map<String, String> user : users) {
               // out.println("User ID: " + user.get("id") + ", Username: " + user.get("username") + "<br>"); // Debugging output
    %>
     <div class="card" onclick="javascript:window.location='view-message.jsp?receiverId=<%= user.get("id") %>';">
        <div class="card-body">
            <span><%= user.get("username") %></span>
            <i class="fas fa-paper-plane"></i>
        </div>
    </div>
    <%
            }
        } else {
            out.println("Users attribute is null"); // Debugging output
        }
    %>
</div>
    
    
    </div>
   <!--  <div class="chat-container">
        <h2>Chat with Friends</h2>
        <div class="chat-box" id="chat-box">
            Dynamic chat messages will appear here
        </div>
        <div class="message-input">
            <input type="text" id="message-input" placeholder="Type a message...">
            <button id="send-button">Send</button>
        </div>
    </div> -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>

	