package vn.iostar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.iostar.configs.JPAConfig;
import vn.iostar.dao.ICommentDao;
import vn.iostar.entity.Comment;

public class CommentDao implements ICommentDao {

    @Override
	public void insert(Comment comment) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(comment);
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
	public void update(Comment comment) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(comment);
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
	public void delete(int commentId) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Comment comment = enma.find(Comment.class, commentId);
            if (comment != null) {
                enma.remove(comment);
            } else {
                throw new Exception("Không tìm thấy bình luận");
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
	public Comment findById(int commentId) {
        EntityManager enma = JPAConfig.getEntityManager();
        Comment comment = enma.find(Comment.class, commentId);
        return comment;
    }


    @Override
	public List<Comment> findAll() {
        EntityManager enma = JPAConfig.getEntityManager();
        TypedQuery<Comment> query = enma.createNamedQuery("Comment.findAll", Comment.class);
        return query.getResultList();
    }


    @Override
	public List<Comment> findByVideoId(String videoId) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT c FROM Comment c WHERE c.videoId = :videoId";
        TypedQuery<Comment> query = enma.createQuery(jpql, Comment.class);
        query.setParameter("videoId", videoId);
        return query.getResultList();
    }


    @Override
	public int count() {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT count(c) FROM Comment c";
        Query query = enma.createQuery(jpql);
        return ((Long) query.getSingleResult()).intValue();
    }
}
