package vn.iostar.dao;

import java.util.List;

import vn.iostar.entity.Comment;

public interface ICommentDao {

	int count();

	List<Comment> findByVideoId(String videoId);

	List<Comment> findAll();

	Comment findById(int commentId);

	void delete(int commentId) throws Exception;

	void update(Comment comment);

	void insert(Comment comment);

}
