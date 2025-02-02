package com.example.haruProject.service.hr;

import java.util.List;

import com.example.haruProject.dto.ShoppingCart;

public interface UserPurchaseService {

	List<ShoppingCart> getShoppingCartList(int memno);

}
