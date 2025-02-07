package com.example.haruProject.dao.hr;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Purchase;
import com.example.haruProject.dto.ShoppingCart;

public interface UserPurchaseDao {

	List<ShoppingCart> getShoppingCartList(int memno);

	void updateSquantity(int pno, int squantity, int memno);

	void deleteSP(int memno, int pno);

	List<ShoppingCart> getorderList(int memno, List<Integer> pnoList);

	Map<String, Object> sPurchase(List<Purchase> pList, int memno, int opayment_mcd, int ototal_price);

	Map<String, Object> kPurchase(List<Purchase> pList, int memno, int opayment_mcd, int ototal_price);

}
