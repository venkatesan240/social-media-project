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
/* Reset some default styles */
body, h2, ul {
    margin: 0;
    padding: 0;
}

body {
    font-family: 'Arial', sans-serif;
}

.friend-list {
    max-width: 300px;
    margin: 20px auto;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.friend-list h2 {
     background-color: #0f160f;
    color: white;
    padding: 10px;
    text-align: center;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    font-size: 1.5em;
}

.modal-body {
    padding: 10px;
}

.card {
    display: flex;
    align-items: center;
    background-color: white;
    margin: 10px 0;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ddd;
    transition: box-shadow 0.3s;
    cursor: pointer;
}

.card:hover {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-body {
    display: flex;
    align-items: center;
    width: 100%;
}

.profile {
    flex-grow: 1;
}

.profile span {
    font-size: 1em;
    font-weight: bold;
    color: #333;
}

.fa-paper-plane {
    color: #060706;
    font-size: 1.2em;
    margin-left: 10px;
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

	