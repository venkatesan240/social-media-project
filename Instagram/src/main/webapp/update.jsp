<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
 .form-container {
            width: 50%;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 2px 2px 12px #aaa;
            font-family: Arial, sans-serif;
            margin-top:50px;
            margin-bottom:50px;
        }
        .form-container h1 {
            text-align: center;
        }
        .form-container span {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .form-container label {
            flex: 1;
        }
        .form-container input {
            flex: 2;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-container button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
        }
        .form-container button:hover {
            background-color: #45a049;
        }

</style>
<body>
<%@include file="header.jsp" %>
	<div class="form-container">
		<h1>Profile Update</h1>
		<form action="UpdateProfile" method="post"
			enctype="multipart/form-data">
			<span> <label for="first-name">First Name:</label> 
			<input	type="text" id="first-name" name="first-name" value="<%= user.getFirstName() %>" required>
			</span> <span> <label for="last-name">Last Name:</label> 
			<input	type="text" id="last-name" name="last-name" value="<%= user.getLastName() %>" required>
			</span> <span> <label for="email">Email:</label> 
			<input type="email"	id="email" name="email"value="<%= user.getEmail() %>"  required>
			</span> <span> <label for="profile-image">Set Profile:</label>
			 <input	type="file" id="profile-image" name="profile-image"  value="<%= user.getProfile() %>" accept="image/*">
			</span>
			<button type="submit">Update Profile</button>
		</form>
	</div>
</body>
</html>