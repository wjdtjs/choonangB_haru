package com.example.haruProject.dao.hj;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProduct;
import com.example.haruProject.dto.SearchItem;

public interface PurchaseHistoryDao {

	List<Order> 		getPurchaseList(int memno, SearchItem si);
	List<OrderProduct> 	getPurchaseProduct(int orderno);
	OrderProduct 		getReviewProduct(OrderProduct product);
	int					addProductReview(Board board);
	int					getMemno(int orderno);
	String 				getPname(String pno);
	Board				getProductReview(OrderProduct op);
	int					updateProdictReview(Board board, boolean img_change);
	int					deleteProductReview(Board board);

}
