package vn.iostar.services.impl;

import java.util.List;

import vn.iostar.dao.ICommentDao;
import vn.iostar.dao.impl.CommentDao;
import vn.iostar.entity.Comment;
import vn.iostar.services.ICommentService;

public class CommentService implements ICommentService{
	ICommentDao cmt=new CommentDao();
	@Override
	public int count() {
		return cmt.count();
	}

	@Override
	public List<Comment> findByVideoId(String videoId) {
		return cmt.findByVideoId(videoId);
	}

	@Override
	public List<Comment> findAll() {
		return cmt.findAll();
	}

	@Override
	public Comment findById(int commentId) {
		return cmt.findById(commentId);
	}

	@Override
	public void delete(int commentId) throws Exception {
		cmt.delete(commentId);
		
	}

	@Override
	public void update(Comment comment) {
		cmt.update(comment);
		
	}

	@Override
	public void insert(Comment comment) {
		cmt.insert(comment);
		
	}
	
}
