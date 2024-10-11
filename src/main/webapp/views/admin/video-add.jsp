<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Video</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }
        input[type="text"],
        input[type="number"],
        select,
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="radio"] {
            margin-right: 5px;
        }
        .radio-group {
            display: flex; /* Hiển thị nút radio trên cùng một hàng */
            align-items: center; /* Căn giữa các nút radio */
            gap: 15px; /* Khoảng cách giữa các nút radio */
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        img {
            margin-top: 10px;
            border-radius: 4px;
            display: none; /* Ảnh không hiển thị trước khi chọn */
            max-width: 100%; /* Đảm bảo ảnh không quá rộng */
            height: auto; /* Giữ tỉ lệ khung hình */
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Thêm Video</h2>
    <form action="<c:url value='/admin/video/insert'></c:url>" method="post" enctype="multipart/form-data">
        <label for="title">Tiêu đề:</label>
        <input type="text" id="title" name="title" required>

        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" required></textarea>

        <label for="views">Lượt xem:</label>
        <input type="number" id="views" name="views" min="0" required>

        <label>Trạng thái:</label>
        <div class="radio-group"> <!-- Thay đổi từ label thành div cho nút radio -->
            <label for="active">
                <input type="radio" id="active" name="active" value="1" checked>
                Kích hoạt
            </label>
            <label for="inactive">
                <input type="radio" id="inactive" name="active" value="0">
                Khóa
            </label>
        </div>

        <label for="categoryId">Thể loại:</label>
        <select id="categoryId" name="categoryId" required>
            <c:forEach var="category" items="${categories}">
                <option value="${category.categoryId}">${category.categoryname}</option>
            </c:forEach>
        </select>

        <label for="poster">Hình ảnh:</label>
        <input type="file" id="poster" name="poster" accept="image/*" onchange="previewImage(this)"><br>
        
        <!-- Khung hiển thị ảnh -->
        <img id="imagePreview" src="" alt="Preview Image">
		
		<label for="videoFile">Chọn Video:</label>
		
		<input type="file" id="videoFile" name="videoFile" accept="video/*" onchange="previewVideo(this)"><br>
		
		<!-- Khung hiển thị video -->
		<video id="videoPreview" width="320" height="240" controls style="display:none;"></video>
		
        <input type="submit" value="Thêm Video">
    </form>
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
