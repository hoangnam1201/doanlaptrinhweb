package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.util.JpaUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;
import java.util.Optional;

public class CategoryDAOImpl implements CategoryDAO {
    private final EntityManagerFactory emf = JpaUtil.getJPAFactory();

    @Override
    public List<Category> getAllParentAndSub() {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Category c join fetch c.children where c.parent=null";
        List<Category> list = em.createQuery(queryString, Category.class).getResultList();
        em.close();
        return list;
    }

    @Override
    public void delete(Long id) {

    }

    @Override
    public void addNew(Category category) {

    }

    @Override
    public void update(Category category) {

    }

    @Override
    public Category findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            Category category = em.find(Category.class, id);
            em.close();
            return category;
        } catch (Exception ex) {
            ex.printStackTrace();
            em.close();
            return null;
        }
    }

    @Override
    public Optional<Category> findBySlug(String slug) {
        return Optional.empty();
    }
}
