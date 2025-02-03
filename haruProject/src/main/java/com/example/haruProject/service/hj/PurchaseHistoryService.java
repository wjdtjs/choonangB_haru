package com.example.haruProject.service.hj;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProduct;

public interface PurchaseHistoryService {

	List<Order> 		getPurchaseHistory(int memno);
	List<OrderProduct> 	getPurchaseProduct(int orderno);
	OrderProduct		getReviewProduct(OrderProduct product);
	int					addProductReview(Board board);
	int					getMemno(int orderno);
	String				getPname(String pno);
	Board				getProductReview(OrderProduct op);
	int					updateProductReview(Board board);
	int					deleteProductReview(Board board);

}
