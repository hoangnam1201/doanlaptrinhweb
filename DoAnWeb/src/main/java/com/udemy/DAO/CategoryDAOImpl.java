package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.util.JpaUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.io.Serializable;
import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {
    private final EntityManagerFactory emf;

    public CategoryDAOImpl() {
        emf = JpaUtil.getJPAFactory();
    }

    @Override
    public List<Category> getAllParentAndSub() {
        EntityManager em = emf.createEntityManager();
        String queryString = "select distinct c from Category c left join fetch c.children where c.parent=null";
        List<Category> list = em.createQuery(queryString, Category.class).getResultList();
        em.close();
        return list;
    }

    @Override
    public List<Category> getMostEnrolledCategoriesLastWeek(int amount) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c " +
                "from Category c left join Course course on course.category.id = c.id " +
                "left join course.enrollments " +
                "where c.parent!=null " +
                "group by c.id " +
                "order by count(course.enrollments.size) desc";
        List<Category> list = em.createQuery(queryString, Category.class).setMaxResults(amount).getResultList();
        em.close();
        return list;
    }

    @Override
    public Category getCategoryById(long id) {
        EntityManager em = emf.createEntityManager();
        Category category = em.find(Category.class, id);
        em.close();
        return category;
    }

    @Override
    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        Category category = em.find(Category.class, id);
        em.getTransaction().begin();
        try {
            em.remove(category);
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }

    }

    @Override
    public void addNew(Category category) {
        EntityManager entityManager = emf.createEntityManager();
        entityManager.getTransaction().begin();
        try {
            entityManager.persist(category);
        } catch (Exception ex) {
            throw ex;
        } finally {
            entityManager.getTransaction().commit();
            entityManager.close();
        }
    }

    @Override
    public void update(Category category) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        try {
            em.merge(category);
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }
    }
}