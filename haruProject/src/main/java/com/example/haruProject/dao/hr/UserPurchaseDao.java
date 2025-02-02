package com.example.haruProject.dao.hr;

import java.util.List;

import com.example.haruProject.dto.ShoppingCart;

public interface UserPurchaseDao {

	List<ShoppingCart> getShoppingCartList(int memno);

}
