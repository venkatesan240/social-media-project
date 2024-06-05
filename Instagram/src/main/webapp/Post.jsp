<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Image Upload</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
	<%-- <%@include file="header.jsp" %>  --%>
    <div class="posts">
        <div class="post-title">
            <div class="post-left">
                <div class="image">
                    <img src="profileicon.png" alt="ff" width="35" height="35">
                </div>
                <div class="details">
                    <p class="name">Frontendforever</p>
                    <p class="location">mukavar</p>
                </div>
            </div>
            <div class="post-right">
                <i class="fa-solid fa-ellipsis"></i>
            </div>
        </div>
        <div class="post-content" id="post-content">
            <img src="profile-1.webp" alt="ff" width="600" height="500" id="uploaded-image">
        </div>
        <div class="post-footer">
            <div class="like-share-commant">
                <i class="fa-regular fa-heart"></i>
                <i class="fa-regular fa-comment"></i>
                <i class="fa-regular fa-paper-plane"></i>
            </div>
            <div class="save">
                <i class="fa-regular fa-bookmark"></i>
            </div>
        </div>
        <div class="add-comment">
            <div class="left-side">
                <i class="fa-regular fa-face-smile-beam"></i>
                <input type="text" placeholder="Add a comment...">
            </div>
            <div class="right-side">
                <p>Post</p>
            </div>
        </div>
    </div>
    <li><a href="#" id="upload-link"><i class="fa-solid fa-square-plus"></i></a></li>
    <input type="file" id="file-input" style="display:none;" accept="image/*">

    <script>
        document.getElementById('upload-link').addEventListener('click', function(e) {
            e.preventDefault();
            document.getElementById('file-input').click();
        });

        document.getElementById('file-input').addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                const formData = new FormData();
                formData.append('image', file);

                fetch('/upload', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    if (data.message === 'File uploaded successfully') {
                        document.getElementById('uploaded-image').src = data.fileUrl;
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
            }
        });
    </script>
</body>
</html>
    