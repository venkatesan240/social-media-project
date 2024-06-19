<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.Base64" %>
<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>
<%
    UserDAO userDAO = new UserDAO();
    String base64Image = "";

    User user = userDAO.getUserById((Integer)(session.getAttribute("userid")));
    if (user != null && user.getProfile() != null) {
        //System.out.println("user null");
        base64Image = Base64.getEncoder().encodeToString(user.getProfile());
    }
%> 
<!DOCTYPE html>
<html>
<style>
/* Profile Page Styles */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f9;
}

h1 {
    text-align: center;
    color: #333;
    margin-top: 20px;
}

div {
    width: 300px;
    margin: 50px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    text-align: center;
}

img {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 20px;
}

p {
    margin: 10px 0;
    color: #666;
    font-size: 16px;
}

p:first-of-type {
    font-weight: bold;
    color: #333;
}
a p {
    margin-top: 20px;
    color: #ea0f0f;
    font-size: 16px;
    font-weight: bold;
    transition: color 0.3s ease;
}

a p:hover {
    color: #0056b3;
}
</style>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>User Profile</h1>
     <div>
      <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Profile Image">
        <p>Username: <%= user.getFirstName() %></p>
        <p>Email: <%= user.getEmail() %></p>
       <a href="update.jsp"><p>Edit profile</p></a>
       <a href="logout"><p>Logout</p></a>
     </div>
</body>
</html>