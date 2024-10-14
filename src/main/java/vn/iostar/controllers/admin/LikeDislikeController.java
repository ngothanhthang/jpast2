/*
 * package vn.iostar.controllers.admin;
 * 
 * import jakarta.servlet.ServletException; import
 * jakarta.servlet.annotation.WebServlet; import
 * jakarta.servlet.http.HttpServlet; import
 * jakarta.servlet.http.HttpServletRequest; import
 * jakarta.servlet.http.HttpServletResponse; import vn.iostar.entity.User;
 * import vn.iostar.entity.Video; import vn.iostar.services.IVideoService;
 * import vn.iostar.services.impl.VideoService; import java.io.IOException;
 * 
 * @WebServlet("/admin/video-like-dislike") public class LikeDislikeController
 * extends HttpServlet {
 * 
 * private static final long serialVersionUID = 1L; private IVideoService
 * videoService = new VideoService();
 * 
 * @Override protected void doPost(HttpServletRequest req, HttpServletResponse
 * resp) throws ServletException, IOException { String videoId =
 * req.getParameter("videoId"); String action = req.getParameter("action"); //
 * "like" hoặc "dislike" User currentUser = (User)
 * req.getSession().getAttribute("user");
 * 
 * // Kiểm tra nếu người dùng chưa đăng nhập if (currentUser == null) {
 * resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
 * return; }
 * 
 * // Lấy thông tin video từ videoId Video video =
 * videoService.findById(videoId); if (video == null) {
 * resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Video not found"); return;
 * }
 * 
 * // Kiểm tra hành động Like hoặc Dislike if ("like".equals(action)) {
 * video.setLikeCount(video.getLikeCount() + 1); // Tăng số lượng Like } else if
 * ("dislike".equals(action)) { video.setDislikeCount(video.getDislikeCount() +
 * 1); // Tăng số lượng Dislike }
 * 
 * // Cập nhật video Video updatedVideo = videoService.findById(videoId); // Tải
 * lại từ cơ sở dữ liệu
 * 
 * // Đặt video đã cập nhật vào request để hiển thị req.setAttribute("video",
 * updatedVideo);
 * 
 * // Quay trở lại trang video chi tiết sau khi cập nhật
 * req.getRequestDispatcher("/admin/video-detail?videoId=" +
 * videoId).forward(req, resp); } }
 */