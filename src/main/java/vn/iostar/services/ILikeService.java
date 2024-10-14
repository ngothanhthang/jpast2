package vn.iostar.services;

import java.util.List;

import vn.iostar.entity.Like;

public interface ILikeService {
	long countDislikes(String videoId);

	long countLikes(String videoId);

	Like findByUserAndVideo(Long userId, String videoId);

	List<Like> findByVideoId(String videoId);

	Like findById(Long likeId);

	void delete(Long likeId) throws Exception;

	void update(Like like);

	void insert(Like like);
}
