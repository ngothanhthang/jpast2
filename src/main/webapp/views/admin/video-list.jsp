<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Video</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: linear-gradient(120deg, #84fab0 0%, #8fd3f4 100%);
        }
        .glass-effect {
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(4px);
            -webkit-backdrop-filter: blur(4px);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
    </style>
</head>

<body class="min-h-screen py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-7xl mx-auto">
        <div class="glass-effect p-8 mb-8">
            <h1 class="text-4xl font-extrabold text-center text-gray-900 mb-8">
                <i class="fas fa-video mr-4"></i>Danh sách Video
            </h1>
            
            <div class="flex justify-center mb-6">
                <form action="<c:url value='/admin/video/search'/>" method="get" class="flex w-full max-w-md">
                    <input type="text" name="title" placeholder="Nhập tiêu đề video" class="w-full px-4 py-2 rounded-l-lg border-t border-b border-l text-gray-800 border-gray-200 bg-white focus:outline-none focus:ring-2 focus:ring-primary" required>
                    <button type="submit" class="px-6 py-2 rounded-r-lg bg-primary text-white font-semibold hover:bg-indigo-600 focus:outline-none focus:ring-2 focus:ring-primary focus:ring-opacity-50 transition duration-300 ease-in-out">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>
            
            <div class="text-center mb-6">
                <a href="<c:url value='/admin/video/add'/>" class="inline-flex items-center px-6 py-3 bg-secondary hover:bg-green-600 text-white font-bold rounded-lg transition duration-300 ease-in-out transform hover:-translate-y-1 hover:scale-105">
                    <i class="fas fa-plus-circle mr-2"></i>Thêm Video
                </a>
            </div>
        </div>

        <div class="glass-effect overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">STT</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Hình đại diện</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Video</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tiêu đề</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Mô tả</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Lượt xem</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Trạng thái</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Thể loại</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Thao tác</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach items="${listVideos}" var="video" varStatus="status">
                        <tr class="hover:bg-gray-50 transition-colors duration-200">
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${status.index + 1}</td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <img src="${pageContext.request.contextPath}/upload/${video.poster}" alt="Poster" class="h-20 w-28 rounded-lg object-cover shadow-md"/>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <video width="150" controls>
                                    <source src="${pageContext.request.contextPath}/uploadvideo/${video.videoPath}" type="video/mp4">
                                </video>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${video.title}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${video.description}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${video.views}</td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-3 py-1 inline-flex items-center text-xs leading-5 font-semibold rounded-full ${video.active == 1 ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                    <i class="fas ${video.active == 1 ? 'fa-check-circle' : 'fa-times-circle'} mr-1"></i>
                                    ${video.active == 1 ? 'Kích hoạt' : 'Khóa'}
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${video.categoryName}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                <a href="<c:url value='/admin/video/edit?id=${video.videoId}'/>" class="text-indigo-600 hover:text-indigo-900 mr-3">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="<c:url value='/admin/video/delete?id=${video.videoId}'/>" class="text-red-600 hover:text-red-900" onclick="return confirm('Bạn có chắc chắn muốn xóa video này?');">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="mt-8 flex justify-center">
            <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                <c:if test="${currentPage > 0}">
                    <a href="<c:url value='/admin/video/search?title=${searchTitle}&page=${currentPage - 1}'/>" class="relative inline-flex items-center px-3 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </c:if>
                <c:forEach begin="0" end="${totalPages - 1}" var="i">
                    <a href="<c:url value='/admin/video/search?title=${searchTitle}&page=${i}'/>" class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium ${i == currentPage ? 'text-primary bg-indigo-50 border-primary z-10' : 'text-gray-700 hover:bg-gray-50'}">${i + 1}</a>
                </c:forEach>
                <c:if test="${currentPage < totalPages - 1}">
                    <a href="<c:url value='/admin/video/search?title=${searchTitle}&page=${currentPage + 1}'/>" class="relative inline-flex items-center px-3 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </c:if>
            </nav>
        </div>
    </div>
</body>

</html>
