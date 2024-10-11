package vn.iostar.controllers.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iostar.entity.Category;
import vn.iostar.services.impl.CategoryService;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet(urlPatterns = {"/admin/categories", "/admin/category/edit", "/admin/category/update",
"/admin/category/insert", "/admin/category/add", "/admin/category/delete","/admin/category/search"})
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CategoryService cateService = new CategoryService();
    private static final int PAGE_SIZE = 5; // Số dòng mỗi trang

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("categories")) {
            // Lấy số trang từ tham số request
            String pageParam = req.getParameter("page");
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 0;

            // Lấy danh sách thể loại cho trang hiện tại
            List<Category> list = cateService.findAll(page, PAGE_SIZE);
            req.setAttribute("listcate", list);

            // Tính toán tổng số trang
            int totalCategories = cateService.count();
            int totalPages = (totalCategories > 0) ? (int) Math.ceil((double) totalCategories / PAGE_SIZE) : 0;

            req.setAttribute("totalPages", totalPages);
            req.setAttribute("currentPage", page);

            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = cateService.findById(id);
            req.setAttribute("cate", category);
            req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                cateService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        } else if (url.contains("/admin/category/search")) {
            String title = req.getParameter("name");
            
            // Tìm kiếm theo tên thể loại
            List<Category> list = cateService.findByCategoryname(title);

            // Cập nhật tổng số trang dựa trên số lượng kết quả tìm kiếm
            int totalCategories = list.size(); // Lấy số lượng mục từ kết quả tìm kiếm
            int totalPages = (int) Math.ceil((double) totalCategories / PAGE_SIZE);
            req.setAttribute("totalPages", totalPages);
            
            // Lấy số trang hiện tại từ tham số (nếu có), nếu không thì mặc định là 0
            String pageParam = req.getParameter("page");
            int currentPage = 0; // Mặc định là trang đầu tiên
            
            try {
                if (pageParam != null) {
                    currentPage = Integer.parseInt(pageParam);
                }
            } catch (NumberFormatException e) {
                currentPage = 0; // Nếu số trang không hợp lệ, mặc định về trang đầu tiên
            }

            // Đảm bảo currentPage không nhỏ hơn 0 và không vượt quá số trang
            if (currentPage < 0) {
                currentPage = 0;
            } else if (currentPage >= totalPages) {
                currentPage = totalPages - 1;
            }

            req.setAttribute("currentPage", currentPage);

            // Lấy danh sách các mục dựa trên trang hiện tại và số mục trên mỗi trang
            int start = currentPage * PAGE_SIZE; // Vị trí bắt đầu
            int end = Math.min(start + PAGE_SIZE, totalCategories); // Vị trí kết thúc
            
            if (start < 0 || start >= totalCategories) {
                start = 0; // Đảm bảo start không nằm ngoài danh sách
            }
            
            List<Category> pagedList = list.subList(start, end);

            req.setAttribute("listcate", pagedList);
            req.setAttribute("searchName", title);

            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        }



    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/admin/category/update")) {
            int categoryid = Integer.parseInt(req.getParameter("categoryid"));
            String categoryname = req.getParameter("categoryname");
            int status = Integer.parseInt(req.getParameter("status"));

            Category category = new Category();
            category.setCategoryId(categoryid);
            category.setCategoryname(categoryname);
            category.setStatus(status);

            // Lưu hình cũ
            Category cateOld = cateService.findById(categoryid);
            String fileOld = cateOld.getImages();

            // Xử lý hình ảnh
            String fname = "";
            String uploadPath = getServletContext().getRealPath("/upload");

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            try {
                Part part = req.getPart("images");
                if (part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    // Đổi tên file
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    // Upload file
                    part.write(uploadPath + "/" + fname);
                    // Ghi tên file vào data
                    category.setImages(fname);
                } else {
                    category.setImages(fileOld); // Giữ lại hình cũ nếu không có hình mới
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            cateService.update(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");

        } else if (url.contains("/admin/category/insert")) {
            Category category = new Category();
            String categoryname = req.getParameter("categoryname");
            int status = Integer.parseInt(req.getParameter("status"));
            category.setCategoryname(categoryname);
            category.setStatus(status);

            String fname = "";
            String uploadPath = getServletContext().getRealPath("/upload");

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            try {
                Part part = req.getPart("images");
                if (part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    // Đổi tên file
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    // Upload file
                    part.write(uploadPath + "/" + fname);
                    // Ghi tên file vào data
                    category.setImages(fname);
                } else {
                    category.setImages("avata.png"); // Giá trị mặc định nếu không có file upload
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }
}
