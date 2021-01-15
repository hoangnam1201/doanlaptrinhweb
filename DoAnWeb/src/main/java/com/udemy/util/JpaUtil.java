package com.udemy.util;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class JpaUtil {
    private static EntityManagerFactory emf = null;

    public static EntityManagerFactory getJPAFactory() {
        if (emf == null) {
            try {
                emf = Persistence.createEntityManagerFactory("udemy");
            } catch (Throwable ex) {
                throw ex;
            }
        }
        return emf;
    }
}
