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
    // Assuming 'post' is available in the request scope
    Integer userId = (Integer) session.getAttribute("userid");
    if (userId == null) {
        userId = -1; // Default value or handle unauthenticated user case
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram-like Post</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
       <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        /* Basic reset */
       * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }

        #posts-container {
            max-width: 600px;
            margin: 0 auto;
        }

        .posts {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
            padding: 15px;
        }

        .post-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .post-left {
            display: flex;
            align-items: center;
        }

        .post-left .image img {
            border-radius: 50%;
        }

        .post-left .details {
            margin-left: 10px;
        }

        .post-right .fa-ellipsis {
            cursor: pointer;
        }

        .delete-option {
            display: none;
            position: absolute;
            background-color: white;
            border: 1px solid #ddd;
            padding: 5px;
        }

        .post-content img {
            width: 100%;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        .post-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #ddd;
            padding-top: 10px;
            margin-top: 10px;
        }

        .like-share-comment {
            display: flex;
            align-items: center;
        }

        .like-button {
            display: flex;
            align-items: center;
            cursor: pointer;
            margin-right: 15px;
        }

        .like-button .fa-heart {
            margin-right: 5px;
            transition: color 0.3s;
        }

        .like-button .fa-heart.active {
            color: #e74c3c;
        }

        .like-share-comment i {
            margin-right: 15px;
            cursor: pointer;
        }

        .add-comment {
            display: flex;
            align-items: center;
            border-top: 1px solid #ddd;
            padding-top: 10px;
            margin-top: 10px;
        }

        .add-comment .left-side {
            flex-grow: 1;
        }

        .add-comment input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .add-comment .right-side p {
            cursor: pointer;
            color: #007BFF;
            margin-left: 10px;
        }

        .fa-heart, .fa-comment, .fa-paper-plane {
            font-size: 24px;
        }
    </style>
</head>
<body>
	<div id="posts-container">
		<% for (Post post : posts) { %>
		<div class="posts">
			<div class="post-title">
				<div class="post-left">
					<div class="image">
						<img src="img/profileicon.png" alt="Profile Icon" width="35"
							height="35">
					</div>
					<div class="details">
						<p class="name"><%= post.getUsername() %></p>
						<p><%= post.getTimestamp() %></p>
					</div>
				</div>
				<div class="post-right">
					<i class="fa-solid fa-ellipsis" onclick="toggleDeleteOption(this)"></i>
					<div class="delete-option">
						<form action="deletePost" method="get">
							<input type="hidden" name="id" value="<%= post.getId() %>">
							<button type="submit">Delete</button>
						</form>
					</div>
				</div>
			</div>
			<div class="post-content">
				<img
					src="data:image/jpg;base64,<%= Base64.getEncoder().encodeToString(post.getImage()) %>"
					alt="Post Content">
				<p><%= post.getDescription() %></p>
			</div>
			<div class="post-footer">
				<div class="like-share-comment">
					<div id="post-<%= post.getId() %>" class="post">
						<i class="fa-regular fa-heart"
							onclick="toggleLike(<%=post.getId()%>, <%=userId%>)"></i> <span
							id="like-count-<%=post.getId()%>"><%=post.getLikeCount()%></span>
						likes
					</div>
				</div>
			</div>
			<div class="add-comment">
				<div class="left-side">
					<input type="text" id="comment-input-<%=post.getId()%>"
						placeholder="Add a comment...">
				</div>
				<div class="right-side">
					<button type="button"
						onclick="addComment(<%=post.getId()%>, <%=userId%>)">Post</button>
				</div>
			</div>
		</div>
		<%
		}
		%>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function toggleDeleteOption(element) {
            const deleteOption = element.nextElementSibling;
            if (deleteOption.style.display === 'none' || deleteOption.style.display === '') {
                deleteOption.style.display = 'block';
            } else {
                deleteOption.style.display = 'none';
            }
        }

        function toggleLike(postId, userId) {
            console.log("toggleLike called with postId:", postId, "userId:", userId);
            console.log("hello");
            const heartIcon = $(`#post-${postId} .fa-heart`);
            const likeCountSpan = $(`#like-count-${postId}`);
            const isLiked = heartIcon.hasClass('fa-solid');

            $.ajax({
                url: 'LikeServlet',
                type: 'POST',
                data: {
                    userId: userId,
                    postId: postId,
                    isLiked: !isLiked
                },
                success: function(response) {
                    likeCountSpan.text(response.likeCount);
                    heartIcon.toggleClass('fa-solid', !isLiked);
                    heartIcon.toggleClass('fa-regular', isLiked);
                },
                error: function(xhr, status, error) {
                    console.error("AJAX request failed: ", status, error);
                }
            });
        }
    </script>
</body>
</html>
