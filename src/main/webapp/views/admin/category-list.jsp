<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Thể loại</title>
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
        <form action="<c:url value='/admin/category/search'></c:url>" method="get" class="inline-block">
            <input type="text" name="name" placeholder="Nhập tên thể loại" class="border border-gray-300 p-2 rounded-lg" required>
            <button type="submit" class="bg-green text-pink border border-gray-300 hover:bg-gray-200 font-bold py-2 px-4 rounded transition duration-300">
                <i class="fas fa-search" style="color: black;"></i>
            </button>
        </form>
    </div>
</body>

	
    <div class="container mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-3xl font-bold mb-4 text-gray-800 text-center">Danh sách Thể loại</h2>
        
        <div class="text-center mb-4">
            <a href="<c:url value='/admin/category/add'></c:url>" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded transition duration-300">
                Thêm Thể loại
            </a>
        </div>

        <div class="table-container">
            <table class="min-w-full border border-gray-300">
                <thead>
                    <tr>
                        <th class="px-4 py-2 border">STT</th>
                        <th class="px-4 py-2 border">Hình ảnh</th>
                        <th class="px-4 py-2 border">Tên Thể loại</th>
                        <th class="px-4 py-2 border">Trạng thái</th>
                        
                        <th class="px-4 py-2 border">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listcate}" var="cate" varStatus="status">
                        <tr class="hover:bg-gray-100 transition duration-300">
                            <td class="px-4 py-2 border">${status.index + 1}</td>

                            <td class="px-4 py-2 border">
                                <c:if test="${not empty cate.images}">
                                    <img src="${pageContext.request.contextPath}/upload/${cate.images}" height="100" width="150" class="rounded"/>
                                </c:if>
                                <c:if test="${empty cate.images}">
                                    <p class="text-red-500">Không có hình ảnh</p>
                                </c:if>
                            </td>

                            <td class="px-4 py-2 border">${cate.categoryname}</td>
                            <td class="px-4 py-2 border">
                                <span class="${cate.status == 1 ? 'text-green-500' : 'text-red-500'}">
                                    ${cate.status == 1 ? 'Kích hoạt' : 'Khóa'}
                                </span>
                            </td>
                            <td class="px-4 py-2 border">
                                <a href="<c:url value='/admin/category/edit?id=${cate.categoryId }'/>" class="text-yellow-500 hover:underline">Sửa</a> |
                                <a href="<c:url value='/admin/category/delete?id=${cate.categoryId }'/>" class="text-red-500 hover:underline">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
	 <!-- Phân trang -->

<div class="flex justify-center mt-4">
    <c:if test="${currentPage > 0}">
        <a href="<c:url value='/admin/category/search?name=${searchName}&page=${currentPage - 1}'/>" 
           class="bg-black text-white hover:bg-gray-800 py-2 px-4 rounded mx-2">
           Trang trước
        </a>
    </c:if>
	<c:if test="${totalPages > 0}">
    <!-- Nút số trang -->
    <c:forEach begin="0" end="${totalPages - 1}" var="i">
        <c:choose>
            <c:when test="${i == currentPage}">
                <span class="bg-white text-black font-bold py-2 px-4 rounded mx-2">${i + 1}</span>
            </c:when>
            <c:otherwise>
                <a href="<c:url value='/admin/category/search?name=${searchName}&page=${i}'/>" 
                   class="bg-black text-white hover:bg-gray-800 py-2 px-4 rounded mx-2">
                   ${i + 1}
                </a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    </c:if>

    <c:if test="${currentPage < totalPages - 1}">
        <a href="<c:url value='/admin/category/search?name=${searchName}&page=${currentPage + 1}'/>" 
           class="bg-black text-white hover:bg-gray-800 py-2 px-4 rounded mx-2">
           Trang tiếp theo
        </a>
    </c:if>
</div>



 </div>
</body>

</html>
