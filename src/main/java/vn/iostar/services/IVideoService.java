package vn.iostar.services;

import java.util.List;

import vn.iostar.dao.IVideoDao;
import vn.iostar.dao.impl.VideoDao;
import vn.iostar.entity.Video;

public interface IVideoService {

	int count();

	List<Video> findAll(int page, int pageSize);

	List<Video> findByTitle(String title);

	List<Video> findAll();

	Video findById(String videoId);

	void delete(String videoId) throws Exception;

	void update(Video video);

	void insert(Video video);

	IVideoDao videoDao = new VideoDao();
	
	List<Video> findByCategoryId(int categoryId);
}
