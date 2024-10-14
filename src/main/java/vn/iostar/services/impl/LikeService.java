package vn.iostar.services.impl;

import java.util.List;

import vn.iostar.dao.ILikeDao;
import vn.iostar.dao.impl.LikeDao;
import vn.iostar.entity.Like;
import vn.iostar.services.ILikeService;

public class LikeService implements ILikeService{
	
	ILikeDao likes=new LikeDao();
	@Override
	public long countDislikes(String videoId) {
		return likes.countDislikes(videoId);
	}

	@Override
	public long countLikes(String videoId) {
		return likes.countLikes(videoId);
	}

	@Override
	public Like findByUserAndVideo(Long userId, String videoId) {
		return likes.findByUserAndVideo(userId, videoId);
	}

	@Override
	public List<Like> findByVideoId(String videoId) {
		return likes.findByVideoId(videoId);
	}

	@Override
	public Like findById(Long likeId) {
		return likes.findById(likeId);
	}

	@Override
	public void delete(Long likeId) throws Exception {
		likes.delete(likeId);
	}

	@Override
	public void update(Like like) {
		likes.update(like);
		
	}

	@Override
	public void insert(Like like) {
		likes.insert(like);
	}



}
