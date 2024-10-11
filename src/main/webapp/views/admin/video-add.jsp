<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Video</title>
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
            <h1 class="text-3xl font-bold text-center text-gray-800 mb-6">
                <i class="fas fa-video mr-2"></i>Thêm Video
            </h1>
            <form action="<c:url value='/admin/video/insert'></c:url>" method="post" enctype="multipart/form-data">
                <label for="title" class="font-semibold">Tiêu đề:</label>
                <input type="text" id="title" name="title" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary">

                <label for="description" class="font-semibold mt-4">Mô tả:</label>
                <textarea id="description" name="description" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary"></textarea>

                <label for="views" class="font-semibold mt-4">Lượt xem:</label>
                <input type="number" id="views" name="views" min="0" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary">

                <label class="font-semibold mt-4">Trạng thái:</label>
                <div class="flex items-center mb-4">
                    <label for="active" class="mr-4">
                        <input type="radio" id="active" name="active" value="1" checked> Kích hoạt
                    </label>
                    <label for="inactive">
                        <input type="radio" id="inactive" name="active" value="0"> Khóa
                    </label>
                </div>

                <label for="categoryId" class="font-semibold mt-4">Thể loại:</label>
                <select id="categoryId" name="categoryId" required class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary">
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}">${category.categoryname}</option>
                    </c:forEach>
                </select>

                <label for="poster" class="font-semibold mt-4">Hình ảnh:</label>
                <input type="file" id="poster" name="poster" accept="image/*" onchange="previewImage(this)" class="w-full py-2 border border-gray-300 rounded-lg">
                <img id="imagePreview" src="" alt="Preview Image" class="h-20 w-28 rounded-lg object-cover mt-2" style="display: none;"/>

                <label for="videoFile" class="font-semibold mt-4">Chọn Video:</label>
                <input type="file" id="videoFile" name="videoFile" accept="video/*" onchange="previewVideo(this)" class="w-full py-2 border border-gray-300 rounded-lg">
                <video id="videoPreview" width="320" height="240" controls style="display:none;" class="mt-2"></video>

                <input type="submit" value="Thêm Video" class="w-full px-4 py-2 mt-6 bg-primary text-white font-semibold rounded-lg hover:bg-blue-700 transition duration-300">
            </form>
        </div>
    </div>

    <script>
        function previewImage(fileInput) {
            const file = fileInput.files[0];
            const imagePreview = document.getElementById('imagePreview');

            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.src = e.target.result;
                    imagePreview.style.display = 'block'; // Hiển thị ảnh sau khi chọn file
                };
                reader.readAsDataURL(file);
            } else {
                imagePreview.src = '';
                imagePreview.style.display = 'none'; // Ẩn ảnh nếu không có file nào
            }
        }

        function previewVideo(fileInput) {
            const file = fileInput.files[0];
            const videoPreview = document.getElementById('videoPreview');

            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    videoPreview.src = e.target.result;
                    videoPreview.style.display = 'block'; // Hiển thị video sau khi chọn file
                };
                reader.readAsDataURL(file);
            } else {
                videoPreview.src = '';
                videoPreview.style.display = 'none'; // Ẩn video nếu không có file nào
            }
        }
    </script>
</body>
</html>
