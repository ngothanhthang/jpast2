package vn.iostar.dao;

import java.util.List;

import vn.iostar.entity.User;

public interface IUserDao {

	int count();

	List<User> findAll(int page, int pageSize);

	List<User> findByUsername(String username);

	List<User> findAll();

	User findById(int userId);

	void delete(int id) throws Exception;

	void update(User user);

	void insert(User user);

}
