package vn.iostar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import vn.iostar.configs.JPAConfig;
import vn.iostar.dao.IRatingDao;
import vn.iostar.entity.Rating;
import java.util.List;

public class RatingDao implements IRatingDao{

    // Thêm đánh giá
	@Override
	public void insert(Rating rating) {
	    EntityManager em = JPAConfig.getEntityManager();
	    EntityTransaction trans = em.getTransaction();
	    try {
	        System.out.println("Inserting rating: " + rating); // Debug thông tin đối tượng rating
	        trans.begin();
	        em.persist(rating); // Thêm mới một đánh giá
	        trans.commit();
	        System.out.println("Rating inserted successfully.");
	    } catch (Exception e) {
	        System.out.println("Error inserting rating: " + e.getMessage());
	        e.printStackTrace();
	        trans.rollback();
	        throw e;
	    } finally {
	        em.close();
	    }
	}


    // Cập nhật đánh giá
    @Override
	public void update(Rating rating) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(rating); // Cập nhật một đánh giá
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // Xóa đánh giá
    @Override
	public void delete(int ratingId) throws Exception {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Rating rating = em.find(Rating.class, ratingId); // Tìm kiếm đánh giá theo ID

            if (rating != null) {
                em.remove(rating); // Xóa đánh giá
            } else {
                throw new Exception("Không tìm thấy đánh giá");
            }

            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // Tìm đánh giá theo ID
    @Override
	public Rating findById(int ratingId) {
        EntityManager em = JPAConfig.getEntityManager();
        return em.find(Rating.class, ratingId); // Tìm đánh giá theo ID
    }

    // Lấy tất cả đánh giá
    @Override
	public List<Rating> findAll() {
        EntityManager em = JPAConfig.getEntityManager();
        String jpql = "SELECT r FROM Rating r";
        TypedQuery<Rating> query = em.createQuery(jpql, Rating.class);
        return query.getResultList(); // Lấy tất cả đánh giá
    }

    // Lấy đánh giá theo video
    @Override
	public List<Rating> findByVideoId(String videoId) {
        EntityManager em = JPAConfig.getEntityManager();
        String jpql = "SELECT r FROM Rating r WHERE r.video.videoId = :videoId";
        TypedQuery<Rating> query = em.createQuery(jpql, Rating.class);
        query.setParameter("videoId", videoId);
        return query.getResultList(); // Lấy đánh giá theo video
    }

    // Tính trung bình đánh giá của video
    @Override
	public double calculateAverageRating(String videoId) {
        EntityManager em = JPAConfig.getEntityManager();
        String jpql = "SELECT AVG(r.ratingValue) FROM Rating r WHERE r.video.videoId = :videoId";
        TypedQuery<Double> query = em.createQuery(jpql, Double.class);
        query.setParameter("videoId", videoId);
        Double average = query.getSingleResult();
        return (average != null) ? average : 0.0; // Trả về giá trị trung bình
    }

    @Override
	public long countAllRatings() {
        EntityManager em = JPAConfig.getEntityManager();
        String jpql = "SELECT COUNT(r) FROM Rating r";
        TypedQuery<Long> query = em.createQuery(jpql, Long.class);
        return query.getSingleResult(); // Trả về tổng số lượng đánh giá
    }
    
    @Override
    public boolean hasUserRatedVideo(String videoId, long userId) {
        EntityManager em = JPAConfig.getEntityManager();  
        
        try {
            // Tạo câu truy vấn JPQL
            String jpql = "SELECT COUNT(r) FROM Rating r WHERE r.video.videoId = :videoId AND r.user.id = :userId";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("videoId", videoId);  
            query.setParameter("userId", userId);    

            // Lấy số lượng đánh giá
            Long count = query.getSingleResult();
            
            System.out.println("Count of ratings found: " + count); // Log số lượng tìm thấy
            
            return count > 0;

        } catch (Exception e) {
            e.printStackTrace();  
            return false;  
        } finally {
            em.close();  
        }
    }
    
    @Override
	public Rating findRatingByUserAndVideo(String videoId, long userId) {
        EntityManager em = JPAConfig.getEntityManager();  
        try {
            // Truy vấn JPQL để tìm đánh giá dựa trên videoId và userId
            String jpql = "SELECT r FROM Rating r WHERE r.video.videoId = :videoId AND r.user.id = :userId";
            TypedQuery<Rating> query = em.createQuery(jpql, Rating.class);
            query.setParameter("videoId", videoId);  
            query.setParameter("userId", userId);    

            return query.getSingleResult(); // Trả về Rating nếu tìm thấy
        } catch (NoResultException e) {
            return null; // Trả về null nếu không tìm thấy
        } finally {
            em.close();
        }
    }

}
