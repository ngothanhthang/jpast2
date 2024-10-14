package vn.iostar.dao;

import java.util.List;

import vn.iostar.entity.Video;

public interface IVideoDao {

	int count();

	List<Video> findAll(int page, int pageSize);

	List<Video> findByTitle(String title);

	List<Video> findAll();

	Video findById(String videoId);

	void delete(String videoId) throws Exception;

	void update(Video video);

	void insert(Video video);

	List<Video> findByCategoryId(int categoryId);

}
