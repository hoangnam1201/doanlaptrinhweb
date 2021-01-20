package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.model.User;
import com.udemy.util.JpaUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;
import java.util.Optional;

public class UserDAOImpl implements UserDAO {
    private final EntityManagerFactory emf = JpaUtil.getJPAFactory();

    public List<User> getAllUser()
    {
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
    public void update(User user)
    {
        EntityManager entityManager=emf.createEntityManager();
        entityManager.getTransaction();
        try {
            entityManager.merge(user);
            entityManager.getTransaction().commit();
        }catch (Exception ex)
        {
            entityManager.getTransaction().rollback();
            throw  ex;
        }
        finally {
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
        }catch (Exception ex)
        {
            em.getTransaction().rollback();
            throw  ex;
        }
        finally {
            em.close();
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
        } finally {
            entityManager.close();
        }
    }
}
