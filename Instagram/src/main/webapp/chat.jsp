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
       /* Friend List Styles */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f9;
}

.friend-list {
    width: 400px;
    margin: 50px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

.friend-list h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
}

.modal-body {
    overflow-y: scroll;
    max-height: 350px;
}

.card {
    padding: 10px;
    margin: 10px 0;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: space-between;
    transition: background-color 0.3s ease;
}

.card:hover {
    background-color: #f0f0f0;
}

.card-body {
    display: flex;
    align-items: center;
}

.card-body span {
    margin-right: 10px;
    font-size: 16px;
    color: #333;
}

.card-body i {
    color: #007bff;
    font-size: 16px;
}
.profile {
            display: flex;
            align-items: center;
        }
        .profile img {
            border-radius: 50%;
            margin-right: 10px;
            width: 50px; /* Adjust size as needed */
            height: 50px; /* Adjust size as needed */
        }
        .profile span {
            font-size: 1.2em;
        }
        
    </style>
</head>
<body>
<%@include file="header.jsp" %>
    <div class="friend-list" id="friend-list">
        <h2>Chat with Friends</h2>
        <div class="modal-body">
            <%
                List<Map<String, String>> users = (List<Map<String, String>>) request.getAttribute("users");
            Integer currentUserIdInt = (Integer) session.getAttribute("userid");
            String currentUserId = currentUserIdInt.toString(); // Convert the user ID to a string
                if (users != null) {
                    for (Map<String, String> user1 : users) {
                        if (!user1.get("id").equals(currentUserId)) {
            %>
            <div class="card" onclick="javascript:window.location='viewmessage.jsp?receiverId=<%= user1.get("id") %>';">
                <div class="card-body">
					<div class="profile">
						 <span><%=user1.get("username")%></span>
					</div>
					<i class="fas fa-paper-plane"></i>
                </div>
            </div>
            <%
                        }
                    }
                }
            %>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>

	