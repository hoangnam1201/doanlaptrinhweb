package com.udemy.DAO;

import com.udemy.model.Wishlist;

public interface WishlistDAO {
    Wishlist getWishlist(long courseId, long userId);
}
