package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.model.Course;
import com.udemy.model.User;
import com.udemy.util.JpaUtil;
import org.hibernate.Hibernate;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import java.util.List;
import java.util.Optional;

public class UserDAOImpl implements UserDAO {
    private final EntityManagerFactory emf = JpaUtil.getJPAFactory();

    @Override
    public User getUserById(long id) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select u from User u where u.id=" + id;
        try {
            User user = em.createQuery(queryString, User.class).getSingleResult();
            Hibernate.initialize(user.getEnrollments());
            return user;
        } catch (NoResultException ex) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public User getUserWithWishlistById(long id) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select u from User u left join fetch u.wishlist where u.id=" + id;
        try {
            User user = em.createQuery(queryString, User.class).getSingleResult();
            Hibernate.initialize(user.getEnrollments());
            return user;
        } catch (NoResultException ex) {
            return null;
        } finally {
            em.close();
        }

    }

    public List<User> getAllUser() {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from User c";
        List<User> list = em.createQuery(queryString, User.class).getResultList();
        em.close();
        return list;
    }


    @Override
    public void addNew(User user) {
        EntityManager entityManager = emf.createEntityManager();
        entityManager.getTransaction().begin();
        try {
            entityManager.persist(user);
        } catch (Exception ex) {
            throw ex;
        } finally {
            entityManager.getTransaction().commit();
            entityManager.close();
        }
    }

    @Override
    public void update(User user) {
        EntityManager entityManager = emf.createEntityManager();
        entityManager.getTransaction().begin();
        try {
            entityManager.merge(user);
            entityManager.getTransaction().commit();
        } catch (Exception ex) {
            entityManager.getTransaction().rollback();
            throw ex;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        User user = em.find(User.class, id);
        em.getTransaction().begin();
        try {
            em.remove(user);
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<User> findByUsername(String username) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            User user = entityManager.createQuery("select u from User u where u.username = :username", User.class)
                    .setParameter("username", username).getSingleResult();
            Hibernate.initialize(user.getEnrollments());
            return Optional.of(user);
        } catch (Exception ex) {
            ex.printStackTrace();
            return Optional.empty();
        } finally {
            entityManager.close();
        }
    }
}
