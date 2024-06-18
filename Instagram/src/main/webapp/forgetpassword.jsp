<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
/* General Styles */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

/* Form Styles */
form {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 300px;
    box-sizing: border-box;
}
h2 {
    font-size: 24px;
    color: #333;
    margin-bottom: 20px;
    text-align: center;
}
.hidden {
    display: none;
}

/* Input Styles */
.input {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 14px;
}

.input:focus {
    border-color: #007bff;
    outline: none;
}

/* Button Styles */
button {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 4px;
    background-color: #c51212;
    color: white;
    font-size: 14px;
    cursor: pointer;
}

button:hover {
    background-color: #1d1a1a;
}

/* Specific Button Class */
.reset-btn {
    margin-top: 10px;
}
.error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
</style>
</head>
<body>
<form action="resetpassword" method="post" onsubmit="return validatePassword()">
<h2>reset password</h2>
		<input type="text" class="input" name="email" placeholder="email" required>
        <input type="password" class="input" id="password" name="password" required placeholder="Password">
        <input type="password" class="input" id="confirm-password" name="confirm-password" required placeholder="Confirm Password">
        <div id="password-error" class="error-message"></div>
         <input type="checkbox" id="toggle-password"> Show Password
        <button type="submit">Submit</button>
    </form>
    <script>
        function validatePassword() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirm-password").value;
            var errorDiv = document.getElementById("password-error");

            if (password !== confirmPassword) {
                errorDiv.textContent = "Passwords do not match. Please try again.";
                return false;
            } else {
                errorDiv.textContent = "";
                return true;
            }
        }
    </script>
    <script>
        const togglePassword = document.querySelector('#toggle-password');
        const password = document.querySelector('#password');
        const confirmPassword = document.querySelector('#confirm-password');

        togglePassword.addEventListener('change', function (e) {
            const type = e.target.checked ? 'text' : 'password';
            password.type = type;
            confirmPassword.type = type;
        });
    </script>
</body>
</body>
</html>