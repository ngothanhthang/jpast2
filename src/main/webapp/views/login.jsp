<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #4e54c8;
            --secondary-color: #8f94fb;
            --text-color: #333;
            --background-color: #f0f2f5;
            --box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        @keyframes gradient {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        .container {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            box-shadow: var(--box-shadow);
            overflow: hidden;
            width: 400px;
            max-width: 100%;
            padding: 40px;
            backdrop-filter: blur(10px);
            transform: translateY(0);
            transition: all 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h2 {
            color: var(--primary-color);
            font-size: 2.5em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .header .icon {
            font-size: 3em;
            color: var(--secondary-color);
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group input {
            width: 100%;
            padding: 15px 15px 15px 50px;
            border: none;
            border-radius: 50px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #f0f0f0;
            color: var(--text-color);
        }

        .form-group input:focus {
            outline: none;
            box-shadow: 0 0 0 2px var(--secondary-color);
        }

        .form-group label {
            position: absolute;
            top: 50%;
            left: 50px;
            transform: translateY(-50%);
            color: #999;
            font-size: 16px;
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .form-group input:focus + label,
        .form-group input:not(:placeholder-shown) + label {
            top: -10px;
            left: 20px;
            font-size: 12px;
            color: var(--primary-color);
            background-color: white;
            padding: 0 5px;
            border-radius: 10px;
        }

        .form-group i {
            position: absolute;
            top: 50%;
            left: 20px;
            transform: translateY(-50%);
            color: var(--primary-color);
            font-size: 20px;
        }

        button {
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            border: none;
            color: white;
            padding: 15px;
            font-size: 18px;
            border-radius: 50px;
            cursor: pointer;
            width: 100%;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        button:hover {
            background: linear-gradient(45deg, var(--secondary-color), var(--primary-color));
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
        }

        .error {
            color: #f44336;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
            background-color: rgba(244, 67, 54, 0.1);
            padding: 10px;
            border-radius: 5px;
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            color: var(--text-color);
        }

        .register-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .register-link a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .container {
                width: 100%;
                border-radius: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="icon"><i class="fas fa-user-circle"></i></div>
            <h2>Đăng Nhập</h2>
        </div>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <input type="text" id="username" name="username" placeholder=" " required>
                <label for="username">Tên Đăng Nhập</label>
                <i class="fas fa-user"></i>
            </div>
            <div class="form-group">
                <input type="password" id="password" name="password" placeholder=" " required>
                <label for="password">Mật Khẩu</label>
                <i class="fas fa-lock"></i>
            </div>
            <button type="submit">Đăng Nhập</button>
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
        </form>
        <div class="register-link">
            <p>Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký tại đây</a>.</p>
        </div>
    </div>
</body>
</html>