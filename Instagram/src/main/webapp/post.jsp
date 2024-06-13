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
        .image {
            width: 50px;
            height: 50px;
            overflow: hidden;
            border-radius: 50%;
            margin-right: 15px;
        }
        .image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .details {
            margin-left: 10px;
        }
        .details .name {
            font-weight: bold;
            margin: 0;
        }
        .details .timestamp {
            color: #777;
            margin: 0;
            font-size: 0.9em;
        }
        .post-content {
            text-align: center;
        }
        .post-content img {
            width: 100%;
            height: auto;
            display: block;
            border-radius: 5px;
        }
        .post-content p {
            text-align: left;
            padding-left: 10px;
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
        .like-share-commant i:hover {
            color: #ff4081;
        }
        .like-share-commant .liked i {
            color: #ff4081;
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
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1000; 
            left: 0;
            top: 0;
            width: 100%; 
            height: 100%; 
            overflow: auto; 
            background-color: rgb(0,0,0); 
            background-color: rgba(0,0,0,0.4); 
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; 
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 10px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
<%@include file="header.jsp" %>
    <div class="post-form">
        <h2>Create a Post</h2>
        <form action="PostServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="username" value="<%= session.getAttribute("name") %>">
            <input type="hidden" name="userid" value="<%= session.getAttribute("userid") %>">
            <input type="file" name="post-image" id="post-image" accept="image/*" required>
            <textarea name="post-content" id="post-content" rows="4" placeholder="Description" required></textarea>
            <button type="submit">Post</button>
        </form>
    </div>

    <div id="posts-container">
        <% for (Post post : posts) { %>
            <div class="posts">
                <div class="post-title">
                    <div class="post-left">
                        <div class="image">
                            <a href="profile.jsp">
                                <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Profile Image">
                            </a>
                        </div>
                        <div class="details">
                            <p class="name"><%= post.getUsername() %></p>
                            <p class="timestamp"><%= post.getTimestamp() %></p>
                        </div>
                    </div>
                    <div class="post-right">
                        <i class="fa-solid fa-ellipsis" onclick="toggleDeleteOption(this)"></i>
                        <div class="delete-option" style="display: none;">
                            <form action="deletePost" method="get">
                                <input type="hidden" name="id" value="<%= post.getId() %>">
                                <button type="submit">Delete</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="post-content">
                    <img src="data:image/jpg;base64,<%= Base64.getEncoder().encodeToString(post.getImage()) %>" alt="Post Content">
                    <p><%= post.getDescription() %></p>
                </div>
                <div class="post-footer">
                    <div class="like-share-commant">
                        <i class="fa-regular fa-heart like-button" onclick="toggleLike(<%= post.getId() %>, <%= userId %>)"></i>
                        <span id="like-count-<%= post.getId() %>"><%= post.getLikeCount() %></span> likes
                    </div>
                    <i class="fa-regular fa-comment" onclick="openCommentModal(<%= post.getId() %>)"></i>
                </div>
                <div class="add-comment">
                    <div class="left-side">
                        <input type="text" placeholder="Add a comment...">
                    </div>
                    <div class="right-side">
                        <p class="text-primary mb-0">Post</p>
                    </div>
                </div>
            </div>
       
    </div>
    <!-- Comment Modal -->
    <div id="commentModal" class="modal">
        <div class="modal-content">
			<span class="close">&times;</span>
			<h3>Comments</h3>
			<div id="commentsContainer"></div>
			<form action="CommentServlet" method="get">
				<textarea id="newComment" rows="3" name="comment"
					placeholder="Add a comment..."></textarea>
				<input type="hidden" name="userid" value="<%=userId%>" /> <input
					type="hidden" name="postid" value="<%=post.getId()%>" />
				<button id="submitComment">Post Comment</button>
			</form>
		</div>
    </div>
 <%
 }
 %>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        // Get the modal
        var modal = document.getElementById("commentModal");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks the button, open the modal 
        function openCommentModal(postId) {
            modal.style.display = "block";
            fetchComments(postId);
            document.getElementById("submitComment").onclick = function() { 
            	submitComment(postId); 
            };
        }

        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }       
    </script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    function toggleLike(postId, userId) {
        console.log("toggleLike called with postId:", postId, "userId:", userId);
        const heartIcon = $(`#post-${postId} .fa-heart`);
        const likeCountSpan = $(`#like-count-${postId}`);
        const isLiked = heartIcon.hasClass('fa-solid');

        console.log("Current like state:", isLiked);

        $.ajax({
            url: 'LikeServlet',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                userId: userId,
                postId: postId,
                isLiked: !isLiked
            }),
            success: function(response) {
                console.log("AJAX success response:", response);
                if (response && response.likeCount !== undefined) {
                    likeCountSpan.text(response.likeCount); // Update the like count in the span
                    if (!isLiked) {
                        heartIcon.removeClass('fa-regular').addClass('fa-solid');
                    } else {
                        heartIcon.removeClass('fa-solid').addClass('fa-regular');
                    }
                } else {
                    console.error("Invalid response format:", response);
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
