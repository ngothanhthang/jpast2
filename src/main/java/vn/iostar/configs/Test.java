package vn.iostar.configs;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iostar.dao.IRatingDao;
import vn.iostar.dao.impl.RatingDao;
import vn.iostar.entity.Category;

public class Test {
	public static void main(String[] args) {
        // Tạo một instance của RatingDao
        IRatingDao ratingDao = new RatingDao();
        
        // Các tham số cần thiết
        String videoId = "436fe911-f335-418d-9f7d-7550cd7b1de5"; // Thay bằng videoId thực tế
        long userId = 1; // Thay bằng userId thực tế

        // Kiểm tra xem người dùng đã đánh giá video chưa
        boolean hasRated = ratingDao.hasUserRatedVideo(videoId, userId);
        
        // In kết quả ra console
        if (hasRated) {
            System.out.println("User has rated the video.");
        } else {
            System.out.println("User has not rated the video.");
        }
    }
}

