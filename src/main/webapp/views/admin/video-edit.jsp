<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật Video</title>
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
        }
        .status-label {
            margin-top: 10px;
        }
        .category-label {
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Cập nhật Video</h2>
    <form action="<c:url value='/admin/video/update'></c:url>" method="post" enctype="multipart/form-data">
        <input type="hidden" id="videoId" name="videoId" value="${video.videoId}">

        <label for="title">Tiêu đề:</label>
        <input type="text" id="title" name="title" value="${video.title}" required>

        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" required>${video.description}</textarea>

        <label for="views">Lượt xem:</label>
        <input type="number" id="views" name="views" value="${video.views}" min="0" required>

        <label class="status-label">Trạng thái:</label>
        <input type="radio" id="active" name="active" value="1" <c:if test="${video.active == 1}">checked</c:if>>
        <label for="active">Kích hoạt</label>
        <input type="radio" id="inactive" name="active" value="0" <c:if test="${video.active == 0}">checked</c:if>>
        <label for="inactive">Khóa</label>

        <label class="category-label" for="categoryId">Chọn thể loại:</label>
        <select id="categoryId" name="categoryId" required>
            <c:forEach items="${categories}" var="category">
                <option value="${category.categoryId}" <c:if test="${category.categoryId == video.category.categoryId}">selected</c:if>>${category.categoryname}</option>
            </c:forEach>
        </select>

        <label for="poster" onclick="return false;">Hình đại diện hiện tại:</label>
        <img id="currentPoster" src="${pageContext.request.contextPath}/upload/${video.poster}" height="150" width="200" alt="Current Poster">

        <label for="poster" onclick="return false;">Thay đổi hình đại diện:</label>
        <input type="file" id="poster" name="poster">
		
		<div id="currentVideoContainer">
    <video id="videoPreview" width="200" controls>
        <source src="${pageContext.request.contextPath}/uploadvideo/${video.videoPath}" type="video/mp4">
    </video>
</div>

<label for="newVideo" onclick="return false;">Tải video mới:</label>
<input type="file" id="newVideo" name="newVideo" accept="video/mp4">


        <input type="submit" value="Cập nhật Video">
    </form>
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


 // Hiển thị video mới
    /* document.getElementById('newVideo').addEventListener('change', function(event) {
        var reader = new FileReader();
        reader.onload = function(e) {
            var videoContainer = document.getElementById('currentVideoContainer');
            videoContainer.innerHTML = ''; // Xóa video hiện tại

            var video = document.createElement('video'); // Tạo thẻ video mới
            video.width = 200; // Đặt chiều rộng
            video.controls = true; // Hiển thị điều khiển

            var source = document.createElement('source'); // Tạo thẻ source cho video
            source.src = e.target.result; // Gán đường dẫn video
            source.type = 'video/mp4'; // Đặt kiểu video

            video.appendChild(source); // Thêm source vào video
            video.innerHTML = 'Trình duyệt của bạn không hỗ trợ thẻ video.'; // Thông báo nếu không hỗ trợ video
            videoContainer.appendChild(video); // Thêm video mới vào trang
        };
        
        console.log(event.target.files[0]); // Kiểm tra tệp video đã chọn
        reader.readAsDataURL(event.target.files[0]); // Đọc file video từ input
    }); */
 
</script>



</body>
</html>
