<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="dao.PostDAO" %>
    <%@ page import="model.Post" %>
    <%@ page import="java.util.List" %>
    <%@ page import="model.Comment" %>
<%@ page import="dao.commentDAO" %>
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
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
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
/* Updated CSS for profile image in posts */
.posts .image {
    width: 50px; /* Adjust as needed */
    height: 50px; /* Adjust as needed */
    overflow: hidden;
    border-radius: 50%;
    margin-right: 15px; /* Adjust spacing as needed */
}

.posts .image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
/* Modal content */
.modal-content {
    background-color: #fefefe;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 500px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    position: relative; /* To position the close button correctly */
}

/* Close button */
.close {
    color: #aaa;
    position: absolute;
    right: 20px;
    top: 20px;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
}

/* Comments container */
#commentsContainer {
    max-height: 200px;
    overflow-y: auto;
    margin-bottom: 20px;
    border-top: 1px solid #ddd;
    padding-top: 10px;
}

#commentsContainer a {
    display: block;
    padding: 5px 0;
    border-bottom: 1px solid #eee;
}

#commentsContainer a:last-child {
    border-bottom: none;
}

/* Form */
form {
    display: flex;
    flex-direction: column;
}

textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 3px;
    border: 1px solid #ccc;
    border-radius: 5px;
    resize: none;
}

button {
    align-self: flex-end;
    padding: 10px 20px;
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #218838;
}
</style>
</head>
<body>
<%@include file="header.jsp" %>
<div id="posts-container">
 <% for (Post post : posts) { %>
        <div class="posts">
            <div class="post-title">
				<div class="post-left">
					<div class="image">
					<a href="profile.jsp">
						<img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(userDAO.getUserById(post.getUserid()).getProfile()) %>" alt="Profile Image">
						</a>
					</div>
					<div class="details">
						<p class="name"><%=post.getUsername()%></p>
						<p><%=post.getTimestamp()%></p>
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
                        <i class="fa-regular fa-heart like-button" onclick="toggleLike(<%= post.getId() %>, <%= userId %>)"></i>
                        <span id="like-count-<%= post.getId() %>"><%= post.getLikeCount() %></span> likes
                    </div>
                    <i class="fa-regular fa-comment" onclick="openCommentModal(<%= post.getId() %>)"></i>
                </div>
                <!-- <div class="add-comment">
                    <div class="left-side">
                        <input type="text" placeholder="Add a comment...">
                    </div>
                    <div class="right-side">
                        <p class="text-primary mb-0">Post</p>
                    </div>
                </div> -->
        </div>
         <!-- Comment Modal -->
    <div id="commentModal" class="modal">
        <div class="modal-content">
			<span class="close">&times;</span>
			<h3>Comments</h3>
			<div id="commentsContainer">
					<% 
					List<Comment> comments = null;
					try {
						comments = commentDAO.getCommentsByPostId(post.getId());
					} catch (ClassNotFoundException e) {
						e.printStackTrace();
					}
					for(Comment comment:comments){ %>
					<a><strong><%= new UserDAO().getUserById(comment.getUserid()).getFirstName() %></strong>: <%= comment.getComment() %></a>
					<%} %>			
			</div>
			<form action="CommentServlet" method="post">
				<textarea id="newComment" rows="3" name="comment"
					placeholder="Add a comment..."></textarea>
				<input type="hidden" name="userid" value="<%=userId%>" /> <input
					type="hidden" name="postid" value="<%=post.getId()%>" />
				<button  id="submitComment">Post Comment</button>
			</form>
		</div>
    </div>
    <% } %>
</div>
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
</body>
</html>