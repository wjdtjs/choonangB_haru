package com.example.haruProject.service.hr;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Purchase;
import com.example.haruProject.dto.ShoppingCart;

public interface UserPurchaseService {

	List<ShoppingCart> getShoppingCartList(int memno);

	void updateSquantity(int pno, int squantity, int memno);

	void deleteSP(int memno, int pno);

	List<ShoppingCart> getorderList(int memno, List<Integer> pnoList);

	Map<String, Object> skPurchase(List<Purchase> pList, int memno, int opayment_mcd, int ototal_price);

}
