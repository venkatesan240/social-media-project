<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.Base64" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="dao.PostDAO" %>
<%@ page import="model.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Comment" %>
<%@ page import="dao.commentDAO" %>
<%@ page import="model.Like" %>
<%@ page import="dao.LikeDAO" %>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
            background-color: #0e0f0f;
            color: white;
            cursor: pointer;
        }
        .post-form button:hover {
            background-color: #202327;
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
       /* Modal container */
.modal {
  /*   display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0; */
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.4);
    justify-content: center;  /* Center horizontally */
    align-items: center;  /* Center vertically */
    display: flex;
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
    position: relative;
    position:absolute;
    left:400px;
    top:140px;
     /* To position the close button correctly */
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
.like-section {
    position: relative;
    display: inline-block;
}

.like-count-tooltip {
    position: relative;
    display: inline-block;
}

.tooltip-content {
    visibility: hidden;
    opacity: 0;
    width: 200px;
    background-color: #f9f9f9;
    color: #000;
    text-align: left;
    border-radius: 5px;
    padding: 10px;
    position: absolute;
    z-index: 1;
    bottom: 125%; /* Position the tooltip above the text */
    left: 60px;
    margin-left: -100px; /* Center the tooltip */
    box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.2);
    transition: opacity 0.3s;
}

.tooltip-content::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: #f9f9f9 transparent transparent transparent;
}

.like-count-tooltip:hover .tooltip-content {
    visibility: visible;
    opacity: 1;
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
        <% for (Post post : posts) { 
         try {
				LikeDAO likeDAO = new LikeDAO();					
				int likecount=likeDAO.getLikeCount(post.getId());
				 post.setLikeCount(likecount);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}%>
            <div class="posts">
                <div class="post-title">
                    <div class="post-left">
                        <div class="image">
                            <a href="profile.jsp">
                                <img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(userDAO.getUserById(post.getUserid()).getProfile()) %>" alt="Profile">
                            </a>
                        </div>
                        <div class="details">
                            <p class="name"><%= post.getUsername() %></p>
                            <span class="comment-timestamp"
					data-timestamp="<%= post.getTimestamp() %>"></span>
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
				<div class="like-share-comment">
					<i id="like-button-<%=post.getId()%>"
						class="fa-regular fa-heart like-button"
						onclick="toggleLike(<%=post.getId()%>, <%=userId%>)"></i> <span
						id="like-count-<%=post.getId()%>" class="like-count-tooltip">
						<%=post.getLikeCount()%>likes
						<div class="tooltip-content" id="tooltip-<%= post.getId() %>">
							<h5>See who liked this post:</h5>
							<ul>
								<%
								LikeDAO likeDAO = new LikeDAO();
								List<User> users = null;
								try {
									users = likeDAO.getUsersWhoLiked(post.getId());
								} catch (ClassNotFoundException e) {
									e.printStackTrace();
								}
								%>
								<%
								for (User user1 : users) {
								%>
								<li><%=user1.getFirstName()%> <%=user1.getLastName()%></li>
								<%
								}
								%>
							</ul>
						</div> </span>
				</div>
				<i class="fa-regular fa-comment" onclick="openCommentModal(<%= post.getId() %>)"></i>
                </div>
            </div>      
    </div>
    <!-- Comment Modal -->
   <div id="commentModal-<%= post.getId() %>" class="modal">
                <div class="modal-content">
                     <span class="close" data-postId="<%= post.getId() %>">&times;</span>
                    <h5>Comments</h5>
                    <div id="commentsContainer-<%= post.getId() %>">
                        <% 
                        List<Comment> comments = null;
                        try {
                            comments = commentDAO.getCommentsByPostId(post.getId());
                        } catch (ClassNotFoundException e) {
                            e.printStackTrace();
                        }
                        if (comments != null) {
                            for (Comment comment : comments) {
                        %>
				<a> <strong><%=new UserDAO().getUserById(comment.getUserid()).getFirstName()%></strong>:
					<%=comment.getComment()%> <span class="comment-timestamp"
					data-timestamp="<%= comment.getCreatedat() %>"></span>
				</a> <br>
				<%
				}
				}
				%>
                    </div>
                    <form action="CommentServlet" method="post">
                        <textarea id="newComment-<%= post.getId() %>" rows="1" name="comment" placeholder="Add a comment..."></textarea>
                        <input type="hidden" name="userid" value="<%= userId %>" /> 
                        <input type="hidden" name="postid" value="<%= post.getId() %>" />
                        <button type="submit" class="submitComment">Post Comment</button>
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
    function toggleDeleteOption(element) {
	    const deleteOption = element.nextElementSibling;
	    if (deleteOption.style.display === 'none' || deleteOption.style.display === '') {
	        deleteOption.style.display = 'block';
	    } else {
	        deleteOption.style.display = 'none';
	    }
	}
    var modals = document.querySelectorAll("[id^='commentModal-']");

    modals.forEach(function(modal) {
        var postId = modal.id.split("-")[1]; // Extract postId from modal id
        var submitButton = modal.querySelector(".submitComment");

        submitButton.onclick = function() {
            submitComment(postId);
        };
    });

    // Function to open comment modal
    function openCommentModal(postId) {
        var modal = document.getElementById("commentModal-" + postId);
        modal.style.display = "block";
    }

 // Function to close comment modal
    function closeCommentModal(postId) {
        var modal = document.getElementById("commentModal-" + postId);
        modal.style.display = "none";
    }

    // Event listener for close buttons using event delegation
    document.addEventListener('click', function(event) {
        if (event.target.classList.contains('close')) {
            var postId = event.target.getAttribute('data-postId');
            closeCommentModal(postId);
        }
    });
    function timeAgo(timestamp) {
        const seconds = Math.floor((new Date() - new Date(timestamp)) / 1000);

        let interval = Math.floor(seconds / 31536000);
        if (interval >= 1) {
            return interval + " year" + (interval === 1 ? "" : "s") + " ago";
        }

        interval = Math.floor(seconds / 2592000);
        if (interval >= 1) {
            return interval + " month" + (interval === 1 ? "" : "s") + " ago";
        }

        interval = Math.floor(seconds / 86400);
        if (interval >= 1) {
            return interval + " day" + (interval === 1 ? "" : "s") + " ago";
        }

        interval = Math.floor(seconds / 3600);
        if (interval >= 1) {
            return interval + " hour" + (interval === 1 ? "" : "s") + " ago";
        }

        interval = Math.floor(seconds / 60);
        if (interval >= 1) {
            return interval + " minute" + (interval === 1 ? "" : "s") + " ago";
        }

        return Math.floor(seconds) + " second" + (seconds === 1 ? "" : "s") + " ago";
    }
    document.addEventListener('DOMContentLoaded', () => {
        const timestampElements = document.querySelectorAll('.comment-timestamp');
        timestampElements.forEach(element => {
            const timestamp = element.getAttribute('data-timestamp');
            element.textContent = timeAgo(timestamp);
        });
    });
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
function toggleLike(postId, userId) {
    const likeButton = document.getElementById('like-button-' + postId);
    const likeCount = document.getElementById('like-count-' + postId);

    // Make an AJAX call to toggle the like
    fetch('LikeServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            postId: postId,
            userId: userId
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Update the like count
            likeCount.textContent = data.likeCount;

            // Toggle the like button class
            if (data.liked) {
                likeButton.classList.remove('fa-regular');
                likeButton.classList.add('fa-solid');
            } else {
                likeButton.classList.remove('fa-solid');
                likeButton.classList.add('fa-regular');
            }
        } else {
            alert('Error toggling like.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error toggling like.');
    });
}
</script>
</body>
</html>
