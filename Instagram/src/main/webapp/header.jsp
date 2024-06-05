<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" /> 
<style>
@charset "ISO-8859-1";
*{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: sans-serif;
}
header{
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 18%;
    border-bottom: 1px solid gray;
    background-color: white;
    position: sticky;
    top: 0;
    z-index: 10;
}
header .logo{
    height: 80px;
}
header .logo img{
height:100%;
    object-fit: contain; 
}
header .search-box{
    width: 300px;
    padding: 3px 16px;
    display: flex;
    align-items: center;
    border: 1px solid #ccc;
    border-radius: 5px;
}
header .search-box input[type="search"] {
    flex: 1;
    border: none;
    outline: none;
    padding: 5px;
    font-size: 14px;
}

header nav ul{
    display: flex;
    list-style: none;
}
header nav ul li{
    margin-right: 40px;
    padding:5px;
}
header nav ul li a img{
    width: 22px;
    height: 22px;
    object-fit: cover;
}
header nav ul li a i{
    font-size: 22px;
    color: rgb(39, 29, 29);
}
.dropdown-content {
    display: none;
    position: absolute;
    margin-right: 10px;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 5px 16px;
    text-decoration: none;
    display: block;
}

 .dropdown-content a:hover {
    background-color: #f1f1f1;
} 

.profile-icon:hover .dropdown-content {
    display: block;
} 

/* Hide checkbox */
.profile-icon input {
    display: none;
}
.profile-icon span {
            margin-left: 10px;
            color: white;
}

/* Style for the dropdown content links */
.dropdown-content a {
display:flex;
  color: black;
  text-decoration: none;
  display: block;
}

/* Style for the dropdown content links on hover */
.dropdown-content a:hover {
  background-color: #ddd;
}

/* Show the dropdown content when hovering over the profile icon */
.nav-item.profile-icon:hover .dropdown-content {
  display: block;
}
.name {
	margin-top:10px;
}

</style>
</head>
<body>
<div class="insta">
        <header>
            <div class="logo">
                <img src="img/connect-high-resolution-logo-black.png" alt="insta" width="140px" height="70px">
            </div>
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="search" placeholder="search">
            </div>
            <nav>
                <ul>
                    <li><a href="#"><i class="fa-solid fa-house"></i></a></li>
                <li><a href="${pageContext.request.contextPath}/chat"><i class="fa-solid fa-message"></i></a></li>
                <li><a href="#"><i class="fa-solid fa-square-plus"></i></a></li>
                <li><a href="#"><i class="fa-solid fa-heart"></i></a></li>
                <ul class="navbar-nav">
                    <li class="nav-item profile-icon">
                        <a href="#">
                        <img src="img/profileicon.png" alt="profile">
                       
                        </a>
                        <div class="dropdown-content">
                            <a href="logout">Logout</a>
                            <a href="update.jsp">Profile Update</a>
                        </div>
                    </li>
                 </ul>
                 <div class="name">
                      <a><%= session.getAttribute("name")%></a>
                    </div>
            </nav>
        </header>
</div>
</body>
</html>