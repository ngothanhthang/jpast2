<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Video</title>
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

        .video-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .video-info {
            padding-top: 20px;
            color: #ffffff;
        }

        .action-buttons {
            display: flex;
            gap: 20px;
            margin: 20px 0;
        }

        .action-buttons button {
            background: linear-gradient(135deg, #42e695 0%, #3bb2b8 100%);
            color: white;
            font-weight: bold;
            padding: 10px;
            border-radius: 10px;
            transition: transform 0.3s, background 0.3s;
            display: inline-flex;
            align-items: center;
            border: none;
            cursor: pointer;
        }

        .action-buttons button:hover {
            background: linear-gradient(135deg, #3bb2b8 0%, #42e695 100%);
            transform: scale(1.1);
        }

        .rating-section, .comments-section {
            margin-top: 30px;
        }

        .rating-bar-container {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.rating-bar {
    height: 20px;
    background: #60a5fa;
    border-radius: 5px;
    transition: width 0.3s;
}

.rating-value {
    width: 50px;
    text-align: center;
    color: #ffffff;
}

.star {
    font-size: 1.5rem; /* Cho ngôi sao trung bình nhỏ hơn */
    color: #ffeb3b;
}


        .star:hover {
            transform: scale(1.2);
        }

        .comments-section textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 10px;
        }

        .comment {
            background: rgba(255, 255, 255, 0.2);
            padding: 10px;
            border-radius: 10px;
            margin-top: 10px;
        }
		        /* Nút Like khi đã được chọn */
		.like-button.liked {
		    background: linear-gradient(135deg, #4caf50 0%, #66bb6a 100%); /* Màu xanh cho like */
		    transform: scale(1.1); /* Phóng to nhẹ */
		    border: 2px solid #4caf50;
		}
		
		/* Nút Dislike khi đã được chọn */
		.dislike-button.disliked {
		    background: linear-gradient(135deg, #f44336 0%, #e57373 100%); /* Màu đỏ cho dislike */
		    transform: scale(1.1); /* Phóng to nhẹ */
		    border: 2px solid #f44336;
		}
		/* Nút Chia sẻ */
		.share-button {
		    background: linear-gradient(135deg, #42a5f5 0%, #42e695 100%);
		    color: white;
		    font-weight: bold;
		    padding: 10px;
		    border-radius: 10px;
		    transition: transform 0.3s, background 0.3s;
		    display: inline-flex;
		    align-items: center;
		    border: none;
		    cursor: pointer;
		}
		
		.share-button:hover {
		    background: linear-gradient(135deg, #42e695 0%, #42a5f5 100%);
		    transform: scale(1.1);
		}
		
		/* Nút Tải xuống */
		.download-button {
		    background: linear-gradient(135deg, #ff9800 0%, #f44336 100%);
		    color: white;
		    font-weight: bold;
		    padding: 10px;
		    border-radius: 10px;
		    transition: transform 0.3s, background 0.3s;
		    display: inline-flex;
		    align-items: center;
		    border: none;
		    cursor: pointer;
		    text-decoration: none;
		}
		
		.download-button:hover {
		    background: linear-gradient(135deg, #f44336 0%, #ff9800 100%);
		    transform: scale(1.1);
		}
        
    </style>
</head>

<body class="min-h-screen py-12 px-4 sm:px-6 lg:px-8">
    <div class="video-container glass-effect">
        <video class="w-full" controls>
            <source src="${pageContext.request.contextPath}/uploadvideo/${video.videoPath}" type="video/mp4">
        </video>

        <div class="video-info">
            <h1 class="text-3xl font-extrabold text-white mb-4">
                ${video.title}
            </h1>
            <div class="action-buttons">
    <!-- Nút Like -->
			    <form action="${pageContext.request.contextPath}/admin/video-detail" method="POST" style="display:inline;">
			        <input type="hidden" name="videoId" value="${video.videoId}">
			        <input type="hidden" name="action" value="like">
			        <button type="submit" class="like-button ${hasLiked ? 'liked' : ''}">
			            <i class="fas fa-thumbs-up mr-2"></i>Like (${video.likesCount})
			        </button>
			    </form>
			
			    <!-- Nút Dislike -->
			    <form action="${pageContext.request.contextPath}/admin/video-detail" method="POST" style="display:inline;">
			        <input type="hidden" name="videoId" value="${video.videoId}">
			        <input type="hidden" name="action" value="dislike">
			        <button type="submit" class="dislike-button ${hasDisliked ? 'disliked' : ''}">
			            <i class="fas fa-thumbs-down mr-2"></i>Dislike (${video.dislikesCount})
			        </button>
			    </form>
			<!-- Nút Chia sẻ qua Facebook -->
					<button type="button" id="share-button" class="share-button">
					    <i class="fas fa-share mr-2"></i>Chia sẻ
					</button>
					
					<script>
					    document.getElementById('share-button').addEventListener('click', function() {
					        // Lấy URL hiện tại của trang video
					        const videoUrl = window.location.href;
					
					        // Định dạng URL chia sẻ qua Facebook
					        const facebookShareUrl = 'https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(videoUrl);
					        
					        // Mở cửa sổ mới để chia sẻ qua Facebook
					        window.open(facebookShareUrl, 'facebook-share-dialog', 'width=800,height=600');
					    });
					</script>


			
			    <!-- Nút Tải xuống -->
			    <a href="${pageContext.request.contextPath}/uploadvideo/${video.videoPath}" download="${video.title}" class="download-button">
			        <i class="fas fa-download mr-2"></i>Tải xuống
			    </a>
			</div>

        </div>
	
        <div class="rating-section">
    <h2 class="text-2xl font-bold text-white mb-4">Đánh giá video</h2>
    
    <!-- Hiển thị điểm trung bình -->
    <div class="text-white mb-4 text-3xl font-bold">
        ${averageRating} <span class="text-sm">/ 5</span>
    </div>
    
    <!-- Khu vực hiển thị sao trung bình -->
    <div class="flex items-center mb-4">
    <div class="flex" id="rating-stars">
        <!-- JavaScript sẽ tự thêm sao vào đây -->
    </div>
    <span class="ml-4 text-white text-sm">(${totalRatings} đánh giá)</span>
</div>

<script>
    // JavaScript để hiển thị sao theo điểm trung bình
    const averageRating = ${averageRating}; // Truyền giá trị từ server
    const fullStars = Math.floor(averageRating);
    const hasHalfStar = (averageRating % 1) >= 0.5;

    // Lấy phần tử chứa sao
    const starContainer = document.getElementById('rating-stars');

    // Thêm các sao đầy đủ
    for (let i = 0; i < fullStars; i++) {
        starContainer.innerHTML += '<i class="fas fa-star" style="color: #ffeb3b;"></i>';
    }

    // Thêm sao nửa nếu có
    if (hasHalfStar) {
        starContainer.innerHTML += '<i class="fas fa-star-half-alt" style="color: #ffeb3b;"></i>';
    }

    // Thêm các sao trống còn lại
    for (let i = fullStars + (hasHalfStar ? 1 : 0); i < 5; i++) {
        starContainer.innerHTML += '<i class="far fa-star" style="color: #e0e0e0;"></i>';
    }
</script>


    <!-- Khu vực biểu đồ lượt đánh giá theo sao -->
    <!-- Biểu đồ số lượng đánh giá của từng sao -->
    <div class="rating-breakdown text-white">
        <c:forEach begin="1" end="5" var="star">
            <div class="rating-bar-container">
                <span class="rating-value">${star} sao</span>
                <div class="flex-grow bg-gray-700 h-4 mx-2 rounded">
                    <div class="rating-bar" style="width: calc(${ratingCountMap[star]} / ${ratings.size()} * 100%)"></div>
                </div>
                <span class="rating-value">(${ratingCountMap[star]})</span>
            </div>
        </c:forEach>
    </div>
</div>


    <!-- Khu vực đánh giá sao -->
		<form action="${pageContext.request.contextPath}/admin/video-detail" method="POST">
		    <div class="stars mb-4" id="star-rating">
		        <c:forEach begin="1" end="5" var="i">
		            <label>
		                <input type="radio" name="ratingValue" value="${i}" style="display:none;" 
		                       ${userRatingValue == i ? 'checked' : ''} onclick="updateStars(${i})" />
		                <i class="fas fa-star star" data-value="${i}" style="cursor:pointer; color: ${i <= userRatingValue ? '#ffeb3b' : '#e0e0e0'};"></i>
		            </label>
		        </c:forEach>
		    </div>
		
		    <!-- Video ID ẩn -->
		    <input type="hidden" name="videoId" value="${video.videoId}">
		    <input type="hidden" name="action" value="rating">
		    <!-- Nút gửi đánh giá -->
		    <button type="submit" class="back-button">Gửi đánh giá</button>
		</form>
		
		<script>
		    function updateStars(selectedValue) {
		        const stars = document.querySelectorAll('#star-rating .star');
		        stars.forEach((star, index) => {
		            star.style.color = (index < selectedValue) ? '#ffeb3b' : '#e0e0e0'; // Màu vàng cho sao đã chọn
		        });
		    }
		</script>

</div>


        <!-- Bình luận -->
        <div class="comments-section">
            <h2 class="text-2xl font-bold text-white mb-4">Bình luận</h2>
            <textarea rows="4" placeholder="Viết bình luận..."></textarea>
            <button class="back-button">Gửi bình luận</button>
            <div class="comment-list">
                <c:forEach items="${comments}" var="comment">
                    <div class="comment">
                        <strong>${comment.username}</strong>: ${comment.content}
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</body>

</html>