<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Video</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <style>
        .table-container {
            overflow-x: auto;
        }

        th {
            background-color: #3b82f6; /* Màu xanh */
            color: white; /* Màu chữ trắng */
        }
    </style>
</head>

<body class="bg-gray-100 p-6">
    <div class="text-center mb-4">
        <form action="<c:url value='/admin/video/search'></c:url>" method="get" class="inline-block">
            <input type="text" name="title" placeholder="Nhập tiêu đề video" class="border border-gray-300 p-2 rounded-lg" required>
            <button type="submit" class="bg-white text-black border border-gray-300 hover:bg-gray-200 font-bold py-2 px-4 rounded transition duration-300">
                <i class="fas fa-search" style="color: black;"></i>
            </button>
        </form>
    </div>
	
    <div class="container mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-3xl font-bold mb-4 text-gray-800 text-center">Danh sách Video</h2>
        
        <div class="text-center mb-4">
            <a href="<c:url value='/admin/video/add'></c:url>" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded transition duration-300">
                Thêm Video
            </a>
        </div>

        <div class="table-container">
            <table class="min-w-full border border-gray-300">
                <thead>
                    <tr>
                        <th class="px-4 py-2 border">STT</th>
                        <th class="px-4 py-2 border">Hình đại diện</th>
                        <th class="px-4 py-2 border">Video</th> <!-- Thêm tiêu đề cho cột video -->
                        <th class="px-4 py-2 border">Tiêu đề</th>
                        <th class="px-4 py-2 border">Mô tả</th>
                        <th class="px-4 py-2 border">Lượt xem</th>
                        <th class="px-4 py-2 border">Trạng thái</th>
                        <th class="px-4 py-2 border">Tên thể loại</th> <!-- Thêm cột Tên thể loại -->
                        <th class="px-4 py-2 border">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listVideos}" var="video" varStatus="status">
                        <tr class="hover:bg-gray-100 transition duration-300">
                            <td class="px-4 py-2 border">${status.index + 1}</td>
                            <td class="px-4 py-2 border">
                                <img src="${pageContext.request.contextPath}/upload/${video.poster}" height="100" width="150" class="rounded"/>
                            </td>
                            <td class="px-4 py-2 border">
						    <video width="150" controls>
						        <source src="${pageContext.request.contextPath}/uploadvideo/${video.videoPath}" type="video/mp4"> <!-- Thay đổi video.filename nếu cần -->
	
						    </video>
						</td> <!-- Hiển thị video -->
                            
                            <td class="px-4 py-2 border">${video.title}</td>
                            <td class="px-4 py-2 border">${video.description}</td>
                            <td class="px-4 py-2 border">${video.views}</td>
                            <td class="px-4 py-2 border">
                                <span class="${video.active == 1 ? 'text-green-500' : 'text-red-500'}">
                                    ${video.active == 1 ? 'Kích hoạt' : 'Khóa'}
                                </span>
                            </td>
                            <td class="px-4 py-2 border">${video.categoryName}</td> <!-- Hiển thị tên thể loại -->
                            <td class="px-4 py-2 border">
                                <a href="<c:url value='/admin/video/edit?id=${video.videoId}'/>" class="text-yellow-500 hover:underline">Sửa</a> |
                                <a href="<c:url value='/admin/video/delete?id=${video.videoId}'/>" class="text-red-500 hover:underline">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="pagination flex justify-center mt-4">
    <c:if test="${currentPage > 0}">
        <a href="<c:url value='/admin/video/search?title=${searchTitle}&page=${currentPage - 1}'/>" 
           class="px-3 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">Trước</a>
    </c:if>
    <c:if test="${totalPages > 0}">
        <c:forEach var="i" begin="0" end="${totalPages - 1}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <span class="px-3 py-2 bg-blue-500 text-white rounded">${i + 1}</span>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/admin/video/search?title=${searchTitle}&page=${i}'/>" 
                       class="px-3 py-2 bg-gray-500 text-white rounded hover:bg-blue-600 mx-1">
                       ${i + 1}
                    </a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </c:if>
    <c:if test="${currentPage < totalPages - 1}">
        <a href="<c:url value='/admin/video/search?title=${searchTitle}&page=${currentPage + 1}'/>" 
           class="px-3 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">Sau</a>
    </c:if>
</div>

        
    </div>
</body>

</html>
