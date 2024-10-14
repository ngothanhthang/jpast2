<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ Tuyệt Đẹp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }
        
        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        .container {
            text-align: center;
            background: rgba(255, 255, 255, 0.8);
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            transform: perspective(1000px) rotateX(5deg);
            transition: all 0.5s ease;
        }
        
        .container:hover {
            transform: perspective(1000px) rotateX(0deg);
        }
        
        h1 {
            color: #333;
            margin-bottom: 30px;
            font-size: 2.8em;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        
        button {
            padding: 15px 30px;
            font-size: 18px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            background: linear-gradient(45deg, #ff6b6b, #feca57);
            color: white;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }
        
        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(50, 50, 93, 0.1), 0 3px 6px rgba(0, 0, 0, 0.08);
        }
        
        button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                120deg,
                transparent,
                rgba(255, 255, 255, 0.4),
                transparent
            );
            transition: all 0.5s;
        }
        
        button:hover::before {
            left: 100%;
        }
        
        .icon {
            margin-right: 10px;
            font-size: 24px;
        }
        
        .decoration {
            position: absolute;
            font-size: 150px;
            color: rgba(255, 255, 255, 0.1);
            pointer-events: none;
            animation: float 6s ease-in-out infinite;
        }
        
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
            100% { transform: translateY(0px); }
        }
        
        .top-left { top: 20px; left: 20px; animation-delay: 0s; }
        .top-right { top: 20px; right: 20px; animation-delay: 1.5s; }
        .bottom-left { bottom: 20px; left: 20px; animation-delay: 3s; }
        .bottom-right { bottom: 20px; right: 20px; animation-delay: 4.5s; }
    </style>
</head>
<body>
    <div class="decoration top-left"><i class="fas fa-star"></i></div>
    <div class="decoration top-right"><i class="fas fa-heart"></i></div>
    <div class="decoration bottom-left"><i class="fas fa-sun"></i></div>
    <div class="decoration bottom-right"><i class="fas fa-moon"></i></div>
    
    <div class="container">
        <h1><i class="fas fa-home icon"></i>Chào Mừng đến với Trang Chủ</h1>
        <button onclick="window.location.href='register'">
            <i class="fas fa-user-plus icon"></i>Đăng Ký
        </button>
    </div>
</body>
</html>