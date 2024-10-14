package vn.iostar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.Query;
import vn.iostar.configs.JPAConfig;
import vn.iostar.dao.ILikeDao;
import vn.iostar.entity.Like;

public class LikeDao implements ILikeDao {


    @Override
	public void insert(Like like) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(like);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }


    @Override
	public void update(Like like) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(like);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }


    @Override
	public void delete(Long likeId) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Like like = enma.find(Like.class, likeId);
            if (like != null) {
                enma.remove(like);
            } else {
                throw new Exception("Không tìm thấy bản ghi like.");
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }


    @Override
	public Like findById(Long likeId) {
        EntityManager enma = JPAConfig.getEntityManager();
        Like like = enma.find(Like.class, likeId);
        return like;
    }


    @Override
	public List<Like> findByVideoId(String videoId) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT l FROM Like l WHERE l.video.videoId = :videoId";
        TypedQuery<Like> query = enma.createQuery(jpql, Like.class);
        query.setParameter("videoId", videoId);
        return query.getResultList();
    }


    @Override
	public Like findByUserAndVideo(Long userId, String videoId) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT l FROM Like l WHERE l.user.id = :userId AND l.video.videoId = :videoId";
        TypedQuery<Like> query = enma.createQuery(jpql, Like.class);
        query.setParameter("userId", userId);
        query.setParameter("videoId", videoId);
        List<Like> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0); // Trả về null nếu không tìm thấy
    }


    @Override
	public long countLikes(String videoId) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT COUNT(l) FROM Like l WHERE l.video.videoId = :videoId AND l.status = 1";
        Query query = enma.createQuery(jpql);
        query.setParameter("videoId", videoId);
        return (long) query.getSingleResult();
    }


    @Override
	public long countDislikes(String videoId) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT COUNT(l) FROM Like l WHERE l.video.videoId = :videoId AND l.status = -1";
        Query query = enma.createQuery(jpql);
        query.setParameter("videoId", videoId);
        return (long) query.getSingleResult();
    }
}
