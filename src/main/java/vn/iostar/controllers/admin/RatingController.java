package vn.iostar.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iostar.entity.Like;
import vn.iostar.entity.Rating;
import vn.iostar.entity.User;
import vn.iostar.entity.Video;
import vn.iostar.services.ILikeService;
import vn.iostar.services.IRatingService;
import vn.iostar.services.IVideoService;
import vn.iostar.services.impl.LikeService;
import vn.iostar.services.impl.RatingService;
import vn.iostar.services.impl.VideoService;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(urlPatterns ={"/admin/video-detail" })

public class RatingController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IRatingService ratingService = new RatingService();
    private IVideoService videoService = new VideoService();
    private ILikeService likeService =new LikeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String videoId = req.getParameter("videoId");

        // Lấy thông tin video từ videoId
        Video video = videoService.findById(videoId);
        if (video == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Video not found");
            return;
        }
        
     // Lấy thông tin người dùng hiện tại
        User currentUser = (User) req.getSession().getAttribute("user");
        
        // Kiểm tra xem người dùng đã like hoặc dislike video này chưa
        Like userLike = null;
        if (currentUser != null) {
            userLike = likeService.findByUserAndVideo(currentUser.getId(), videoId);
        }

        // Truyền trạng thái like/dislike tới JSP
        boolean hasLiked = false;
        boolean hasDisliked = false;
        if (userLike != null) {
            hasLiked = userLike.getStatus() == 1;    // Nếu người dùng đã like
            hasDisliked = userLike.getStatus() == -1; // Nếu người dùng đã dislike
        }
     // Kiểm tra xem người dùng đã đánh giá video chưa
        Rating userRating = null;
        int userRatingValue = 0;  // Mặc định là 0 nếu chưa có đánh giá
        if (currentUser != null) {
            userRating = ratingService.findRatingByUserAndVideo(videoId, currentUser.getId());
            if (userRating != null) {
                userRatingValue = userRating.getRatingValue(); // Lấy số sao người dùng đã đánh giá
            }
        }
        
        // Lấy danh sách bình luận và đánh giá
        List<Rating> ratings = ratingService.findByVideoId(videoId);
        double averageRating = ratingService.calculateAverageRating(videoId);

        Map<Integer, Long> ratingCountMap = new HashMap<>();
        // Đảm bảo đủ 5 sao
        for (int i = 1; i <= 5; i++) {
            ratingCountMap.put(i, 0L); // Mặc định là 0 lượt
        }
        // Cập nhật theo dữ liệu thực tế
        ratingCountMap.putAll(ratings.stream()
            .collect(Collectors.groupingBy(Rating::getRatingValue, Collectors.counting())));

        req.setAttribute("video", video);
        req.setAttribute("ratings", ratings);
        req.setAttribute("averageRating", averageRating);
        req.setAttribute("ratingCountMap", ratingCountMap);
        req.setAttribute("hasLiked", hasLiked);
        req.setAttribute("hasDisliked", hasDisliked);
        req.setAttribute("userRatingValue", userRatingValue); // Số sao người dùng đã đánh giá
        req.setAttribute("currentUser", currentUser);

        req.getRequestDispatcher("/views/admin/video-detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
       
        String videoId = req.getParameter("videoId");
        String action = req.getParameter("action");
        User currentUser = (User) req.getSession().getAttribute("user");

        // Kiểm tra người dùng đã đăng nhập chưa
        if (currentUser == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        // Lấy thông tin video từ videoId
        Video video = videoService.findById(videoId);
        if (video == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Video not found");
            return;	
        }
        if ("like".equals(action)) {
        	// Kiểm tra nếu người dùng đã like/dislike video này chưa
            Like existingLike = likeService.findByUserAndVideo(currentUser.getId(), videoId);

            if (existingLike != null) {
                // Nếu đã tồn tại, cập nhật trạng thái thành like
                existingLike.setStatus(1); // 1: Like
                likeService.update(existingLike);
            } else {
                // Nếu chưa có, tạo bản ghi mới với trạng thái like
                Like newLike = new Like(currentUser, video, 1);
                likeService.insert(newLike);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/video-detail?videoId=" + videoId);
            return;
        } else if ("dislike".equals(action)) {
        	// Kiểm tra nếu người dùng đã like/dislike video này chưa
            Like existingLike = likeService.findByUserAndVideo(currentUser.getId(), videoId);

            if (existingLike != null) {
                // Nếu đã tồn tại, cập nhật trạng thái thành dislike
                existingLike.setStatus(-1); // -1: Dislike
                likeService.update(existingLike);
            } else {
                // Nếu chưa có, tạo bản ghi mới với trạng thái dislike
                Like newLike = new Like(currentUser, video, -1);
                likeService.insert(newLike);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/video-detail?videoId=" + videoId);
            return;
        } else if ("rating".equals(action)) {
            int ratingValue = Integer.parseInt(req.getParameter("ratingValue"));

     // Kiểm tra nếu người dùng đã đánh giá video này chưa
        Rating existingRating = ratingService.findRatingByUserAndVideo(videoId, currentUser.getId());
        
        if (existingRating != null) {
            System.out.println("Existing rating found, updating...");
            existingRating.setRatingValue(ratingValue); // Cập nhật giá trị đánh giá

            // Gọi phương thức update từ IRatingService
            try {
                ratingService.update(existingRating);
                System.out.println("Rating updated successfully.");
            } catch (Exception e) {
                System.out.println("Error updating rating: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            System.out.println("No existing rating, inserting new...");
            Rating rating = new Rating();
            rating.setRatingValue(ratingValue);
            rating.setVideo(video);
            rating.setUser(currentUser);
            ratingService.insert(rating);
        }


        // Tính lại điểm trung bình sau khi lưu
        double averageRating = ratingService.calculateAverageRating(videoId);

        // Cập nhật điểm trung bình và trả về trang chi tiết video
        req.setAttribute("averageRating", averageRating);
        resp.sendRedirect(req.getContextPath() + "/admin/video-detail?videoId=" + videoId);
        }
    }
}