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
        .post-content img {
            width: 100%;
            height: auto;
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
    </style>
</head>
<body>

<div class="post-form">
    <h2>Create a Post</h2>
    <form id="create-post-form" enctype="multipart/form-data">
        <input type="file" name="post-image" id="post-image" accept="image/*" required>
        <textarea name="post-content" id="post-content" rows="4" placeholder="What's on your mind?" required></textarea>
        <button type="submit">Post</button>
    </form>
</div>

<div id="posts-container"></div>

<script>
    document.getElementById('create-post-form').addEventListener('submit', function(event) {
        event.preventDefault();

        const imageInput = document.getElementById('post-image');
        const contentInput = document.getElementById('post-content');
        const postsContainer = document.getElementById('posts-container');

        const imageFile = imageInput.files[0];
        const reader = new FileReader();

        reader.onload = function(e) {
            const postHTML = `
                <div class="posts">
                    <div class="post-title">
                        <div class="post-left">
                            <div class="image">
                                <img src="profileicon.png" alt="Profile Icon" width="35" height="35">
                            </div>
                            <div class="details">
                                <p class="name">example</p>
                            </div>
                        </div>
                        <div class="post-right">
                            <i class="fa-solid fa-ellipsis"></i>
                        </div>
                    </div>
                    <div class="post-content">
                        <img src="${e.target.result}" alt="Post Content">
                        <p>${contentInput.value}</p>
                    </div>
                    <div class="post-footer">
                        <div class="like-share-commant">
                            <i class="fa-regular fa-heart"></i>
                            <i class="fa-regular fa-comment"></i>
                        </div>
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
            `;
            postsContainer.innerHTML += postHTML;
        };

        reader.readAsDataURL(imageFile);
        imageInput.value = '';
        contentInput.value = '';
    });
</script>

</body>
</html>
