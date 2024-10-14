<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Videos trong thể loại</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: linear-gradient(120deg, #ff7e5f 0%, #feb47b 100%);
            font-family: 'Inter', sans-serif;
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.5);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 20px;
        }

        /* Hiệu ứng hover cho thẻ video */
        .video-card {
            background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        .video-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
            background: linear-gradient(135deg, #fad0c4 0%, #ff9a9e 100%);
        }

        .video-thumbnail {
            object-fit: cover;
            height: 180px;
            width: 100%;
            border-bottom: 3px solid #ff7e5f;
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .video-thumbnail:hover {
            opacity: 0.85;
            transform: scale(1.05);
        }

        .video-info {
            padding: 15px;
            text-align: left;
            color: #ffffff;
        }

        .video-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
        }

        .video-title i {
            margin-right: 8px;
            color: #ffd700;
            transition: transform 0.3s ease;
        }

        .video-title:hover {
            color: #ffeb3b;
        }

        .video-title:hover i {
            transform: rotate(20deg);
        }

        .video-category {
            font-size: 1rem;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
        }

        .video-category i {
            margin-right: 6px;
            color: #ffca28;
        }

        .video-views {
            font-size: 1rem;
            color: #e0f7fa;
            display: flex;
            align-items: center;
        }

        .video-views i {
            margin-right: 6px;
            color: #4fc3f7;
        }

        /* Grid layout cho video */
        .video-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        /* Nút trở về */
        .back-button {
            background: linear-gradient(135deg, #42e695 0%, #3bb2b8 100%);
            color: white;
            font-weight: bold;
            padding: 10px 20px;
            border-radius: 10px;
            transition: transform 0.3s, background 0.3s;
            display: inline-flex;
            align-items: center;
        }

        .back-button:hover {
            background: linear-gradient(135deg, #3bb2b8 0%, #42e695 100%);
            transform: scale(1.1);
        }
    </style>
</head>

<body class="min-h-screen py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-7xl mx-auto">
        <div class="glass-effect text-center mb-8">
            <h1 class="text-5xl font-extrabold text-white mb-8">
                <i class="fas fa-video mr-4"></i>Danh sách Video thuộc thể loại: ${category.categoryname}
            </h1>
        </div>

        <!-- Grid layout cho các video -->
        <div class="video-grid">
            <c:forEach items="${videos}" var="video" varStatus="status">
                <!-- Video card -->
                <div class="video-card" onclick="window.location.href='${pageContext.request.contextPath}/admin/video-detail?videoId=${video.videoId}'">
                    <!-- Video Thumbnail -->
                    <video class="video-thumbnail" controls>
                        <source src="${pageContext.request.contextPath}/uploadvideo/${video.videoPath}" type="video/mp4">
                    </video>

                    <!-- Thông tin video -->
                    <div class="video-info">
                        <h2 class="video-title">
                            <i class="fas fa-play-circle"></i> ${video.title}
                        </h2>
                        <p class="video-category">
                            <i class="fas fa-folder"></i> Thể loại: ${video.category.categoryname}
                        </p>
                        <p class="video-views">
                            <i class="fas fa-eye"></i> ${video.views} lượt xem
                        </p>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Nút trở về -->
        <div class="mt-8 flex justify-center">
            <a href="${pageContext.request.contextPath}/admin/categories" class="back-button">
                <i class="fas fa-arrow-left mr-2"></i>Trở về danh sách thể loại
            </a>
        </div>
    </div>
</body>

</html>