package vn.iostar.services.impl;

import java.util.List;

import vn.iostar.entity.User;
import vn.iostar.services.IUserService;

public class UserService implements IUserService {

    @Override
	public void insert(User user) {
        userDao.insert(user);  // Gọi phương thức insert của tầng DAO
    }

    @Override
	public void update(User user) {
        userDao.update(user);  // Gọi phương thức update của tầng DAO
    }

    @Override
	public void delete(int id) throws Exception {
        userDao.delete(id);  // Gọi phương thức delete của tầng DAO
    }

    @Override
	public User findById(int id) {
        return userDao.findById(id);  // Gọi phương thức findById của tầng DAO
    }

    @Override
	public List<User> findAll() {
        return userDao.findAll();  // Gọi phương thức findAll của tầng DAO
    }

    @Override
	public List<User> findByUsername(String username) {
        return userDao.findByUsername(username);  // Gọi phương thức findByUsername của tầng DAO
    }

    @Override
	public List<User> findAll(int page, int pageSize) {
        return userDao.findAll(page, pageSize);  // Gọi phương thức phân trang từ tầng DAO
    }

    @Override
	public int count() {
        return userDao.count();  // Gọi phương thức đếm số lượng user từ tầng DAO
    }

	@Override
	public User login(String username, String password) {
	    // Giả sử bạn có phương thức truy vấn tìm người dùng theo username
	    List<User> users = userDao.findByUsername(username);
	    
	    if (users.size() > 0) {
	        User user = users.get(0); // Lấy người dùng đầu tiên
	        // Kiểm tra mật khẩu (nếu cần)
	        if (user.getPassword().equals(password)) {
	            return user;
	        }
	    }
	    return null; // Nếu không tìm thấy hoặc mật khẩu không chính xác
	}

}
