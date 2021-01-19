package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.util.JpaUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {
    private EntityManagerFactory emf;

    public CategoryDAOImpl() {
        emf = JpaUtil.getJPAFactory();
    }

    @Override
    public List<Category> getAllParentAndSub() {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Category c join fetch c.children where c.parent=null";
        List<Category> list = em.createQuery(queryString, Category.class).getResultList();
        em.close();
        return list;
    }

    @Override
    public List<Category> getMostEnrolledCategoriesLastWeek(int amount) {
        return null;
    }

    @Override
    public void delete(Long id) {

    }

    @Override
    public void addNew(Category category) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        try {
            em.persist(category);
        } catch (Exception ex) {
            throw ex;
        } finally {
            em.getTransaction().commit();
            em.close();
        }
    }

    @Override
    public void update(Category category) {

    }
}
