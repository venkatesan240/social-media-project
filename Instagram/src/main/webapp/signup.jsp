<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
   <!--  <link rel="stylesheet" href="sign.css"> -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<title>Register</title>
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
    margin-top: 50px;
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
    background-color: rgb(1, 183, 255);
    border: none;
    border-radius: 8px;
    margin: 8px 0px;
    color: white;
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
</style>
</head>
<body>
 <main>
        <img src="img/karsten-winegeart-60GsdOMRFGc-unsplash.jpg" alt="instagram-logo-illustration.png" class="phoneImg">	
        <div class="form-div">
            <form action="signup" method="post">
                <img class="instaLogo" src="img/connect-high-resolution-logo-black.png" alt="logo">
                <input type="text" class="input" name="first-name" placeholder="first name" required>
                <input type="text" class="input" name="last-name" placeholder="last name" required>
                <input type="text" class="input" name="email" placeholder="email" required>
                <input type="password" class="input" name="password" required placeholder="Password">
                <input type="password" class="input" name="confirm-password" required placeholder="confirm Password">
                <button class="login-btn">Register</button>
<% 
    // Check if there's an error message
    String errorMessage = (String) request.getAttribute("error");
    if (errorMessage != null) {
%>
        <script type="text/javascript">
            alert("<%= errorMessage %>");
        </script>
<%
    }
%>
				<!-- <p id="or">or</p> -->
                <!-- <a href="#" class="fb-login"><i class='bx bxl-facebook-square'></i>Log in with Facebook</a> -->
            </form>
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