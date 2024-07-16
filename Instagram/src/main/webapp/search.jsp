<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
/* General styles */
body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            padding: 20px;
        }

        .search-box {
            position: relative;
            width: 300px;
            margin: 20px auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            overflow: hidden;
            background-color: #fff;
        }

        .search-box input[type="search"] {
            width: 100%;
            padding: 10px 40px 10px 20px;
            border: none;
            outline: none;
            font-size: 16px;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .search-box .fa-magnifying-glass {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            color: #aaa;
            cursor: pointer;
            font-size: 18px;
        }

        #searchResults {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            background: white;
            border: 1px solid #ddd;
            border-top: none;
            max-height: 200px;
            overflow-y: auto;
            box-sizing: border-box;
            border-radius: 0 0 5px 5px;
            z-index: 1000;
        }

        #searchResults div {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            cursor: pointer;
        }

        #searchResults div:hover {
            background: #f0f0f0;
        }

</style>
</head>
<body>
<div class="search-box">
          <input type="search" id="searchBox" placeholder="Search" oninput="searchUsers()">
          <i class="fa-solid fa-magnifying-glass" onclick="searchUsers()"></i>
          <div id="searchResults"></div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
    function searchUsers() {
        const query = document.getElementById('searchBox').value;
        const resultsContainer = document.getElementById('searchResults');

        if (query.length === 0) {
            resultsContainer.style.display = 'none';
            resultsContainer.innerHTML = '';
            return;
        }

        // AJAX request to the servlet
        const xhr = new XMLHttpRequest();
        xhr.open('GET', `search?query=${encodeURIComponent(query)}`, true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                const results = JSON.parse(xhr.responseText);
                if (results.length === 0) {
                    resultsContainer.style.display = 'none';
                    resultsContainer.innerHTML = '';
                    return;
                }
                resultsContainer.style.display = 'block';
                resultsContainer.innerHTML = results.map(user => `<div>${user}</div>`).join('');

                // Add click event to each result item
                Array.from(resultsContainer.children).forEach(child => {
                    child.addEventListener('click', function() {
                        document.getElementById('searchBox').value = this.textContent;
                        resultsContainer.style.display = 'none';
                    });
                });
            }
        };
        xhr.send();
    }

    // Hide results when clicking outside the search box
    document.addEventListener('click', function(event) {
        const searchBox = document.getElementById('searchBox');
        const searchResults = document.getElementById('searchResults');
        if (!searchBox.contains(event.target) && !searchResults.contains(event.target)) {
            searchResults.style.display = 'none';
        }
    });
</script>
</body>
</html>