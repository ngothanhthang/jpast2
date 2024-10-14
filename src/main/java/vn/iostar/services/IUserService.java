package vn.iostar.services;

import java.util.List;

import vn.iostar.dao.IUserDao;
import vn.iostar.dao.impl.UserDao;
import vn.iostar.entity.User;

public interface IUserService {

	int count();

	List<User> findAll(int page, int pageSize);

	List<User> findByUsername(String username);

	List<User> findAll();

	User findById(int userId);

	void delete(int userId) throws Exception;

	void update(User user);

	void insert(User user);

	User login(String username, String password);

	IUserDao userDao = new UserDao();
	
}
