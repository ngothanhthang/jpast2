package vn.iostar.services;

import java.util.List;

import vn.iostar.entity.Rating;

public interface IRatingService{
	double calculateAverageRating(String videoId);

	List<Rating> findByVideoId(String videoId);

	List<Rating> findAll();

	Rating findById(int ratingId);

	void delete(int ratingId) throws Exception;

	void update(Rating rating);

	void insert(Rating rating);
	
	long countAllRatings();
	
	boolean hasUserRatedVideo(String videoId, long userId);
	
	Rating findRatingByUserAndVideo(String videoId, long userId);
}
