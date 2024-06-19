<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <!--  <link rel="stylesheet" href="sign.css"> -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700&family=Ubuntu:wght@300;400;500&display=swap');
* {
    padding: 0;
    margin: 0;
    outline: 0;
    text-decoration: none;
}

body {
    background-color: #fff;
    font-family: 'Roboto', sans-serif;
}

main {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 100px;
    min-height: 100vh;
    margin: auto;
}

.form-div {
    display: flex;
    flex-direction: column;
}
.phoneImg{
    height: 500px;
    margin-right: 50px;
}
.form-div form {
    display: flex;
    flex-direction: column;
    text-align: center;
    align-items: center;
    justify-content: center;
    padding: 3vh 2vw;
    border: 1px solid rgba(128, 128, 128, 0.3);
    margin-top: 30px;
}

.form-div form .instaLogo {
    width: 200px;
    margin: 1px ;
}

.form-div form .input {
    width: 90%;
    padding: .8rem;
    border-radius: 8px;
    border: 1px solid rgba(128, 128, 128, 0.3);
    margin: 5px;
}

.login-btn {
    width: 97%;
    padding: .4rem;
    font-weight: 700;
     background-color: rgb(235, 15, 15);
    border: none;
    border-radius: 8px;
    margin: 8px 0px;
    color: white;
}
.login-btn:hover{
	 background-color: rgb(18, 17, 17);
}

#or {
    margin: 20px 0;
}

#or:before,
#or:after {
    content: '------------------------';
    color: rgba(128, 128, 128, 0.7);
    margin: 0 10px;
}

.fb-login {
    font-weight: 700;
    font-size: 95%;
    color: rgb(85, 0, 255);
    margin-bottom: 30px;
    margin-top: 10px;
}

.sign-up {
    text-align: center;
    border: 1px solid rgba(128, 128, 128, 0.3);
    padding: 20px;
    margin: 10px;
}

.get-app {
    display: flex;
    flex-direction: column;
    text-align: center;
}

.store {
    display: flex;
    align-items: center;
}

#play {
    width: 190px;
}

#microsoft {
    width: 135px;
    border-radius: 8px;
}
.forgetpassword{
	background-color:white;
}
    </style>
</head>
<body>
<%
if(session == null){
	response.sendRedirect("signin.jsp");
}
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.
%>
<main>
        <img src="img/karsten-winegeart-60GsdOMRFGc-unsplash.jpg" alt="" class="phoneImg">
        <div class="form-div">
     <form id="login-form" action="signin" method="post">
        <img class="instaLogo" src="img/connect-high-resolution-logo-black.png" alt="logo">
        <input type="text" class="input" name="email" placeholder="phone number, username, or email" required>
        <input type="password" class="input" name="password" required placeholder="Password">
        <button type="submit" class="login-btn">Log In</button>
        <button type="button" id="forgot-password" class="forgetpassword"><a href="forgetpassword.jsp">Forgot Password?</a></button>
     </form>
<% 
    // Check if there's an error message
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
%>
        <script type="text/javascript">
            alert("<%= errorMessage %>");
        </script>
<%
    }
%>
<% 
    // Check if there's an error message
    String Message = (String) request.getAttribute("Message");
    if (Message != null) {
%>
        <script type="text/javascript">
            alert("<%= Message %>");
        </script>
<%
    }
%>
            <div class="sign-up">
                <p>Don't have an account? <a href="signup.jsp" class="sign-link">Sign up</a></p>
            </div>
            <div class="get-app">
                <p>Get the app</p>
                <div class="store">
                    <img id="play" src="img/playStore.png" alt="">
                    <img id="microsoft" src="img/getMicrosoft.png" alt="">
                </div>
            </div>
        </div>
    </main>
</body>
</html>