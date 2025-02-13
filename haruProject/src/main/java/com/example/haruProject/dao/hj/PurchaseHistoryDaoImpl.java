package com.example.haruProject.dao.hj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProduct;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PurchaseHistoryDaoImpl implements PurchaseHistoryDao {
	private final SqlSession session;

	@Override
	public List<Order> getPurchaseList(int memno,SearchItem si) {
		System.out.println("Dao memail-> "+ memno);
		Map<String, Object> list_map = new HashMap<>();
		list_map.put("memno", memno);
		list_map.put("si", si);
		List<Order> purchaseList = new ArrayList<>();
		
		try {
			purchaseList = session.selectList("HJSelectPurchseHistory", list_map);
			System.out.println("Dao purchaseList-> "+ purchaseList);
		} catch (Exception e) {
			System.out.println("PurchaseHistoryDao getPurchaseList e.getMessage()->"+ e.getMessage());
		}
		return purchaseList;
	}

	@Override
	public List<OrderProduct> getPurchaseProduct(int orderno) {
		List<OrderProduct> products = new ArrayList<>();
		
		try {
			products = session.selectList("HJSelectPurchaseProduct",orderno);
		} catch (Exception e) {
			System.out.println("PurchaseHistoryDao getPurchaseProduct e.getMessage()->"+ e.getMessage());
		}
		return products;
	}

	@Override
	public OrderProduct getReviewProduct(OrderProduct product) {
		OrderProduct op = null;
		try {
			op = session.selectOne("HJ_SelectReviewProductInfo", product);
			System.out.println("Dao op-> "+op);
		} catch (Exception e) {
			System.out.println("PurchaseHistory getReviewProduct e.getMessage()-> "+e.getMessage());
		}
		return op;
	}

	@Override
	public int addProductReview(Board board) {
		int result = 0;
		try {
			result = session.insert("HJ_insertProductReview",board);
		} catch (Exception e) {
			System.out.println("PurchaseHistory addProductReview 에러 -> "+e.getMessage());
		}
		return result;
	}

	@Override
	public int getMemno(int orderno) {
		int memno = 0;
		try {
			memno = session.selectOne("HJgetMemno",orderno);
		} catch (Exception e) {
			System.out.println("PurchaseHistory getMemno 에러 -> "+e.getMessage());
		}
		return memno;
	}

	@Override
	public String getPname(String pno) {
		String pname = null;
		try {
			pname = session.selectOne("HJgetPname",pno);
		} catch (Exception e) {
			System.out.println("PurchaseHistory getPname 에러 -> "+e.getMessage());
		}
		return pname;
	}

	@Override
	public Board getProductReview(OrderProduct op) {
		Board board = new Board();
		try {
			board = session.selectOne("HJ_selectProductReview",op);
			System.out.println("Dao getProductReview board->"+board);
		} catch (Exception e) {
			System.out.println("PurchaseHistory getProductReview 에러 -> "+e.getMessage());
		}
		return board;
	}

	@Override
	public int updateProdictReview(Board board, boolean img_change) {
		int result = 0;
		Map<String, Object> update_map = new HashMap<>();
		update_map.put("ic", img_change);
		update_map.put("board", board);
		try {
			result = session.update("HJ_updateProductReview", update_map);
		} catch (Exception e) {
			System.out.println("PurchaseHistory updateProdictReview 에러 -> "+e.getMessage());
		}
		return result;
	}

	@Override
	public int deleteProductReview(Board board) {
		int result = 0;
		try {
			result = session.delete("HJ_deletePriducrReview", board);
		} catch (Exception e) {
			System.out.println("PurchaseHistory deleteProductReview 에러 -> "+e.getMessage());
		}
		return result;
	}
}
