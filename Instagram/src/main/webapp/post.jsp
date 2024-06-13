<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.Base64" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="dao.PostDAO" %>
<%@ page import="model.Post" %>
<%@ page import="java.util.ArrayList" %>
<%
    PostDAO postDAO = new PostDAO();
    List<Post> posts = new ArrayList<>();
    try {
        posts = postDAO.getAllPosts();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<% 
        int userId = (int) session.getAttribute("userid");
        %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram-like Post</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f8f8;
        }
        .post-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
            margin-bottom: 20px;
        }
        .post-form h2 {
            margin-top: 0;
        }
        .post-form input[type="file"] {
            display: block;
            margin-bottom: 15px;
        }
        .post-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .post-form button {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        .post-form button:hover {
            background-color: #0056b3;
        }
        .posts {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
            margin-bottom: 20px;
            overflow: hidden;
        }
        .post-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }
        .post-left {
            display: flex;
            align-items: center;
        }
        .image img {
            border-radius: 50%;
        }
        .details {
            margin-left: 10px;
        }
        .details .name {
            font-weight: bold;
            margin: 0;
        }
        .details .location {
            color: #777;
            margin: 0;
            font-size: 0.9em;
        }
        .post-content {
            text-align: center;
        }
        .post-content p{
            text-align:left;
            padding-left:10px;
        }
       /* Ensure the image within the post-content class maintains its aspect ratio and does not become oval */
        .post-content img {
            width: 100%;  /* Make the image take the full width of its container */
            height: auto; /* Maintain the aspect ratio */
            display: block; /* Ensure there's no extra space below the image */
            border-radius: 0; /* Remove any border-radius if applied */
        }
       
        .post-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-top: 1px solid #ddd;
        }
        .like-share-commant i {
            margin-right: 15px;
            cursor: pointer;
        }
        .save i {
            cursor: pointer;
        }
        .add-comment {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-top: 1px solid #ddd;
        }
        .left-side {
            display: flex;
            align-items: center;
            width: 80%;
        }
        .left-side i {
            margin-right: 10px;
        }
        .left-side input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 20px;
        }
        .right-side p {
            margin: 0;
            color: #007bff;
            cursor: pointer;
        }
       /*  likes */
        .like-button {
            cursor: pointer;
        }
        .like-button .fa-heart {
            color: #ccc; /* Default color */
           transition: color 0.3s; 
        }
        .like-button .fa-heart:hover {
            color: #ff4081; /* Change color on hover */
        }
        .like-button .liked .fa-heart {
            color: #ff4081; /* Color when liked */
        }	 
       /* Post Right Styles */
        .post-right {
            position: relative;
            display: inline-block;
        }

        .post-right i {
            cursor: pointer;
            font-size: 20px;
            color: #333;
        }

        .delete-option {
            position: absolute;
            top: 20px;
            right: 0;
            background-color: #fff;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 10px;
            border-radius: 4px;
            z-index: 1000;
        }

        .delete-option button {
            background-color: #e74c3c;
            color: #fff;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 4px;
            font-size: 14px;
        }

        .delete-option button:hover {
            background-color: #c0392b;
        }
        
    </style>
</head>
<body>
<%@include file="header.jsp" %>
<div class="post-form">
    <h2>Create a Post</h2>
    <form action="PostServlet" method="post" enctype="multipart/form-data">
    	<input type="hidden" name="username" value="<%= session.getAttribute("name") %>" />
    	<input type="hidden" name="userid" value="<%= session.getAttribute("userid") %>" />
        <input type="file" name="post-image" id="post-image" accept="image/*" required>
        <textarea name="post-content" id="post-content" rows="4" placeholder="Description" required></textarea>
        <button type="submit">Post</button>
    </form>
</div>

<div id="posts-container">
 <% for (Post post : posts) { %>
        <div class="posts" id="post-<%= post.getId() %>">
            <div class="post-title">
                <div class="post-left">
                    <div class="image">
                        <img src="img/profileicon.png" alt="Profile Icon" width="35" height="35">
                    </div>
                    <div class="details">
                        <p class="name"><%= post.getUsername() %></p>
                        <p><%= post.getTimestamp() %></p>
                    </div>
                </div>
				<div class="post-right">
					<i class="fa-solid fa-ellipsis" onclick="toggleDeleteOption(this)"></i>
					<div class="delete-option" style="display: none;">
						<form action="deletePost" method="get">
							<input type="hidden" name="id" value="<%=post.getId()%>">
							<button type="submit">Delete</button>
						</form>
					</div>
				</div>
				<script>
				function toggleDeleteOption(element) {
				    const deleteOption = element.nextElementSibling;
				    if (deleteOption.style.display === 'none' || deleteOption.style.display === '') {
				        deleteOption.style.display = 'block';
				    } else {
				        deleteOption.style.display = 'none';
				    }
				}

				</script>
			</div>
            <div class="post-content">
                <img src="data:image/jpg;base64,<%= Base64.getEncoder().encodeToString(post.getImage()) %>" alt="Post Content">
                <p><%= post.getDescription() %></p>
            </div>
            <div class="post-footer">
                <div class="like-share-commant">
                    <i class="fa-regular fa-heart" onclick="toggleLike(<%= post.getId() %>, <%= userId %>)"></i>
                    <span id="like-count"> <%= post.getLikeCount() %> </span> likes
                </div>
                <i class="fa-regular fa-comment"></i>
            </div>
            <div class="add-comment">
                <div class="left-side">
                    <input type="text" placeholder="Add a comment...">
                </div>
                <div class="right-side">
                    <p>Post</p>
                </div>
            </div>
        </div>
    <% } %>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    function toggleLike(postId, userId) {
        console.log("toggleLike called with postId:", postId, "userId:", userId);
        const heartIcon = $(`#post-${postId} .fa-heart`);
        const likeCountSpan = $(`#like-count-${postId}`);
        const isLiked = heartIcon.hasClass('fa-solid');
        console.log("like", likeCountSpan);
        console.log("Current like state:", isLiked);

        $.ajax({
            url: 'LikeServlet',
            type: 'POST',
            data: {
                userId: userId,
                postId: postId,
                isLiked: !isLiked
            },
            success: function(response) {
                console.log("AJAX success response:", response);
                if (likeCountSpan.length) {
                    likeCountSpan.text(response.likeCount + " likes"); // Correctly set the like count text
                    document.getElementById("like-count").innerHTML = response.likeCount;
                } else {
                    console.error(`Element with ID 'like-count-${postId}' not found.`);
                }
                if (!isLiked) {
                    heartIcon.removeClass('fa-regular').addClass('fa-solid');
                } else {
                    heartIcon.removeClass('fa-solid').addClass('fa-regular');
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX request failed: ", status, error);
            }
        });
        
    }
</script>

</body>
</html>

