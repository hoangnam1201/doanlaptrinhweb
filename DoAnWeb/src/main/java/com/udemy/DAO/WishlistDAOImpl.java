package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.model.Wishlist;
import com.udemy.util.JpaUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import java.util.List;

public class WishlistDAOImpl implements WishlistDAO {
    private final EntityManagerFactory emf = JpaUtil.getJPAFactory();


    @Override
    public Wishlist getWishlist(long courseId, long userId) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select w from Wishlist w where w.user.id = ?1 and w.course.id = ?2";
        try {
            return em.createQuery(queryString, Wishlist.class)
                    .setParameter(1, userId).setParameter(2, courseId).getSingleResult();
        } catch (NoResultException ex) {
            return null;
        } finally {
            em.close();
        }
    }
}
