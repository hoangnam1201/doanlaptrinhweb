package com.udemy.DAO;

import com.udemy.model.User;
import com.udemy.util.JpaUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.Optional;

public class UserDAOImpl implements UserDAO {
    private final EntityManagerFactory emf = JpaUtil.getJPAFactory();

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
    public Optional<User> findByUsername(String username) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            User user = entityManager.createQuery("select u from User u where u.username = :username", User.class)
                    .setParameter("username", username).getSingleResult();
            return Optional.ofNullable(user);
        } catch (Exception ex) {
            ex.printStackTrace();
            return Optional.empty();
        }
    }
}
