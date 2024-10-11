package vn.iostar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.iostar.configs.JPAConfig;
import vn.iostar.dao.IUserDao;
import vn.iostar.entity.User;

public class UserDao implements IUserDao {
    

    @Override
	public void insert(User user) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(user);  // Thêm mới một người dùng
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
	public void update(User user) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(user);  // Cập nhật người dùng
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
	public void delete(int userId) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            User user = enma.find(User.class, userId);  // Tìm kiếm người dùng theo ID

            if (user != null) {
                enma.remove(user);  // Xóa người dùng
            } else {
                throw new Exception("Không tìm thấy người dùng");
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
	public User findById(int userId) {
        EntityManager enma = JPAConfig.getEntityManager();
        return enma.find(User.class, userId);  // Tìm người dùng theo ID
    }

    @Override
	public List<User> findAll() {
        EntityManager enma = JPAConfig.getEntityManager();
        TypedQuery<User> query = enma.createNamedQuery("User.findAll", User.class);  // Truy vấn tất cả người dùng
        return query.getResultList();
    }

    @Override
	public List<User> findByUsername(String username) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.username like :username";
        TypedQuery<User> query = enma.createQuery(jpql, User.class);
        query.setParameter("username", "%" + username + "%");
        return query.getResultList();
    }

    @Override
	public List<User> findAll(int page, int pageSize) {
        EntityManager enma = JPAConfig.getEntityManager();
        TypedQuery<User> query = enma.createNamedQuery("User.findAll", User.class);
        query.setFirstResult(page * pageSize);  // Thiết lập vị trí bắt đầu
        query.setMaxResults(pageSize);  // Giới hạn số lượng kết quả
        return query.getResultList();
    }

    @Override
	public int count() {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT count(u) FROM User u";
        Query query = enma.createQuery(jpql);
        return ((Long) query.getSingleResult()).intValue();
    }
}
