package vn.iostar.services.impl;

import java.util.List;

import vn.iostar.dao.IRatingDao;
import vn.iostar.dao.impl.RatingDao;
import vn.iostar.entity.Rating;
import vn.iostar.services.IRatingService;

public class RatingService implements IRatingService{
	IRatingDao rate=new RatingDao();
	@Override
	public double calculateAverageRating(String videoId) {
		return rate.calculateAverageRating(videoId);
	}

	@Override
	public List<Rating> findByVideoId(String videoId) {
		return rate.findByVideoId(videoId);
	}

	@Override
	public List<Rating> findAll() {
		return rate.findAll();
	}

	@Override
	public Rating findById(int ratingId) {
		return rate.findById(ratingId);
	}

	@Override
	public void delete(int ratingId) throws Exception {
		rate.delete(ratingId);
	}

	@Override
	public void update(Rating rating) {
		rate.update(rating);
		
	}

	@Override
	public void insert(Rating rating) {
		rate.insert(rating);
		
	}

	@Override
	public long countAllRatings() {
		return rate.countAllRatings();
	}


	@Override
	public boolean hasUserRatedVideo(String videoId, long userId) {
		return rate.hasUserRatedVideo(videoId, userId);
	}

	@Override
	public Rating findRatingByUserAndVideo(String videoId, long userId) {
		return rate.findRatingByUserAndVideo(videoId, userId);
	}
}
