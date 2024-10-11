<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật Video</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3b82f6',  // Thay đổi màu chính
                        secondary: '#ef4444', // Thay đổi màu thứ cấp
                    }
                }
            }
        }
    </script>
    <style>
        body {
            background: linear-gradient(120deg, #d3cce3 0%, #e9e4f0 100%);  /* Thay đổi màu nền */
        }
        .glass-effect {
            background: rgba(255, 255, 255, 0.5);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(6px);
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.5);
        }
    </style>
</head>
<body class="min-h-screen py-12 px-4 sm:px-6 lg:px-8">
<div class="max-w-3xl mx-auto">
    <div class="glass-effect p-6 mb-8">
        <h2 class="text-3xl font-bold text-center text-gray-800 mb-6">
            <i class="fas fa-video mr-2"></i>Cập nhật Video
        </h2>
        <form action="<c:url value='/admin/video/update'></c:url>" method="post" enctype="multipart/form-data">
            <input type="hidden" id="videoId" name="videoId" value="${video.videoId}">

            <label for="title" class="font-semibold">Tiêu đề:</label>
            <input type="text" id="title" name="title" value="${video.title}" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary">

            <label for="description" class="font-semibold mt-4">Mô tả:</label>
            <textarea id="description" name="description" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary">${video.description}</textarea>

            <label for="views" class="font-semibold mt-4">Lượt xem:</label>
            <input type="number" id="views" name="views" value="${video.views}" min="0" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary">

            <label class="font-semibold mt-4">Trạng thái:</label>
            <div class="flex items-center mb-4">
                <label for="active" class="mr-4">
                    <input type="radio" id="active" name="active" value="1" <c:if test="${video.active == 1}">checked</c:if>> Kích hoạt
                </label>
                <label for="inactive">
                    <input type="radio" id="inactive" name="active" value="0" <c:if test="${video.active == 0}">checked</c:if>> Khóa
                </label>
            </div>

            <label class="font-semibold mt-4" for="categoryId">Chọn thể loại:</label>
            <select id="categoryId" name="categoryId" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary">
                <c:forEach items="${categories}" var="category">
                    <option value="${category.categoryId}" <c:if test="${category.categoryId == video.category.categoryId}">selected</c:if>>${category.categoryname}</option>
                </c:forEach>
            </select>

            <label class="font-semibold mt-4" for="poster">Hình đại diện hiện tại:</label>
            <img id="currentPoster" src="${pageContext.request.contextPath}/upload/${video.poster}" height="150" width="200" alt="Current Poster" class="rounded-lg"/>

            <label class="font-semibold mt-4" for="poster">Thay đổi hình đại diện:</label>
            <input type="file" id="poster" name="poster" class="w-full py-2 border border-gray-300 rounded-lg">
            
            <div id="currentVideoContainer" class="mt-4">
                <video id="videoPreview" width="200" controls>
                    <source src="${pageContext.request.contextPath}/uploadvideo/${video.videoPath}" type="video/mp4">
                </video>
            </div>

            <label class="font-semibold mt-4" for="newVideo">Tải video mới:</label>
            <input type="file" id="newVideo" name="newVideo" accept="video/mp4" class="w-full py-2 border border-gray-300 rounded-lg">

            <input type="submit" value="Cập nhật Video" class="w-full px-4 py-2 mt-6 bg-primary text-white font-semibold rounded-lg hover:bg-blue-700 transition duration-300">
        </form>
    </div>
</div>

<!-- JavaScript để xử lý việc chọn tệp và hiển thị ảnh mới -->
<script>
    // Hiển thị hình đại diện mới
    document.getElementById('poster').addEventListener('change', function(event) {
        var reader = new FileReader();
        reader.onload = function(e) {
            var image = document.getElementById('currentPoster');
            image.src = e.target.result; // Cập nhật ảnh mới
        };
        reader.readAsDataURL(event.target.files[0]);
    });

    // Hiển thị video mới
    document.getElementById('newVideo').addEventListener('change', function(event) {
        var reader = new FileReader();
        reader.onload = function(e) {
            var video = document.getElementById('videoPreview'); // Lấy thẻ video
            video.src = e.target.result; // Cập nhật đường dẫn video mới
            video.style.display = 'block'; // Hiển thị video mới
            video.load(); // Tải video mới
        };
        reader.readAsDataURL(event.target.files[0]);
    });
</script>

</body>
</html>
