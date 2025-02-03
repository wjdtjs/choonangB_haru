package com.example.haruProject.service.hj;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.PurchaseHistoryDao;
import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProduct;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PurchaseHistoryServiceImpl implements PurchaseHistoryService {
	private final PurchaseHistoryDao pd;

	@Override
	public List<Order> getPurchaseHistory(int memno) {
		List<Order> purchaseList = pd.getPurchaseList(memno);
		return purchaseList;
	}

	@Override
	public List<OrderProduct> getPurchaseProduct(int orderno) {
		List<OrderProduct> products = pd.getPurchaseProduct(orderno);
		return products;
	}

	@Override
	public OrderProduct getReviewProduct(OrderProduct product) {
		OrderProduct op = pd.getReviewProduct(product);
		return op;
	}

	@Override
	public int addProductReview(Board board) {
		int result = pd.addProductReview(board);
		return result;
	}

	@Override
	public int getMemno(int orderno) {
		int memno = pd.getMemno(orderno);
		return memno;
	}

	@Override
	public String getPname(String pno) {
		String pname = pd.getPname(pno);
		return pname;
	}

	@Override
	public Board getProductReview(OrderProduct op) {
		Board board = pd.getProductReview(op);
		return board;
	}

	@Override
	public int updateProductReview(Board board) {
		int result = pd.updateProdictReview(board);
		return result;
	}

	@Override
	public int deleteProductReview(Board board) {
		int result = pd.deleteProductReview(board);
		return result;
	}
}
