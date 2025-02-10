package com.example.haruProject.dao.hr;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.haruProject.dto.Purchase;
import com.example.haruProject.dto.ShoppingCart;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class UserPurchaseDaoImp implements UserPurchaseDao {
	private final SqlSession session;

	// 장바구니 리스트 불러오기
	@Override
	public List<ShoppingCart> getShoppingCartList(int memno) {
		System.out.println("UserPurchaseDaoImp getShoppingCartList() start ,,,");
		System.out.println("UserPurchaseDaoImp getShoppingCartList() memno ->"+memno);
		
		List<ShoppingCart> sList = new ArrayList<>();
		
		try {
			sList = session.selectList("HR_getshoppingCartList", memno);
			System.out.println("UserPurchaseDaoImp sList ->"+sList);
		} catch (Exception e) {
			log.error("getShoppingCartList() error ->", e);
		}
		
		return sList;
	}

	// 장바구니 수량 변경에 따른 DB update
	@Override
	@Transactional		// 자동 commit
	public void updateSquantity(int pno, int squantity, int memno) {
		System.out.println("UserPurchaseDaoImp updateSquantity() start ,,,");
		System.out.println("UserPurchaseDaoImp updateSquantity() pno ->"+pno);
		System.out.println("UserPurchaseDaoImp updateSquantity() squantity ->"+squantity);
		System.out.println("UserPurchaseDaoImp updateSquantity() memno ->"+memno);
		
		Map<String, Object> uMap = new HashMap<>();
		uMap.put("pno", pno);
		uMap.put("squantity", squantity);
		uMap.put("memno", memno);
		
		try {
			session.update("HR_updateSquantity", uMap);
		} catch (Exception e) {
			log.error("updateSquantity() error ->", e);
		}
	}

	// 장바구니 품목 삭제
	@Override
	public void deleteSP(int memno, int pno) {
		System.out.println("UserPurchaseServiceImp deleteSP() start ,,,");
		System.out.println("UserPurchaseServiceImp deleteSP() memno ->"+memno);
		System.out.println("UserPurchaseServiceImp deleteSP() pno ->"+pno);
		
		Map<String, Object> dMap = new HashMap<>();
		dMap.put("memno", memno);
		dMap.put("pno", pno);
		
		try {
			session.delete("HR_deleteShoppingProduct", dMap);
		} catch (Exception e) {
			log.error("deleteSP() error ->", e);
		}
	}

	// 선택된 주문 상품 정보 불러오기
	@Override
	public List<ShoppingCart> getorderList(int memno, List<Integer> pnoList) {
		System.out.println("UserPurchaseDaoImp getorderList() start ,,,");
		System.out.println("UserPurchaseDaoImp getorderList() memno ->"+memno);
		System.out.println("UserPurchaseDaoImp getorderList() pnoList ->"+pnoList);
		
		List<ShoppingCart> sList = new ArrayList<>();
		
		Map<String, Object> sMap = new HashMap<>();
		sMap.put("memno", memno);
		sMap.put("pnoList", pnoList);
		
		try {
			sList = session.selectList("HR_getOrderList", sMap);
		} catch (Exception e) {
			log.error("deleteSP() error ->", e);
		}
		
		return sList;
	}

	// 매장 결제 주문 
	@Override
	public int sPurchase(List<Purchase> pList, int memno, int opayment_mcd, int ototal_price) {
		System.out.println("UserPurchaseDaoImp storePurchase() start ,,,");
		System.out.println("UserPurchaseDaoImp storePurchase() memno ->"+memno);
		System.out.println("UserPurchaseDaoImp storePurchase() pList ->"+pList);
		
		// List<Purchase> List = new ArrayList<>();
		
		Map<String, Object> pMap = new HashMap<>();
		// pMap.put("pList", pList);
		pMap.put("memno", memno);
		pMap.put("opayment_mcd", opayment_mcd);
		pMap.put("ototal_price", ototal_price);
		pMap.put("ostatus_mcd", 100);
		
		pMap.put("orderno", null);
		
		System.out.println("pMap ->"+pMap);
		
		int orderno = 0;
		
		try {
			session.update("HR_addPurchase", pMap);  // 프로시저 실행
			BigDecimal ordernoDecimal = (BigDecimal) pMap.get("orderno");  // BigDecimal로 캐스팅
			orderno = ordernoDecimal != null ? ordernoDecimal.intValue() : null;
			System.out.println("dao out orderno ->"+orderno);
			
			for (Purchase purchase : pList) {
				Map<String, Object> insertMap = new HashMap<>();
				
				insertMap.put("purchase", purchase);
				insertMap.put("memno", memno);
				insertMap.put("orderno", orderno);
				session.update("HR_processOrderProducts", insertMap);
			}
		} catch (Exception e) {
			log.error("sPurchase() error ->", e);
		}
		
		return orderno;
	}
	
	// 카카오페이 주문
	@Override
	public int kPurchase(List<Purchase> pList, int memno, int opayment_mcd, int ototal_price) {
		System.out.println("UserPurchaseServiceImp storePurchase() start ,,,");
		System.out.println("UserPurchaseServiceImp storePurchase() memno ->"+memno);
		System.out.println("UserPurchaseServiceImp storePurchase() pList ->"+pList);
		
		int orderno = 0;
		
		Map<String, Object> pMap = new HashMap<>();
		pMap.put("pList", pList);
		pMap.put("memno", memno);
		pMap.put("opayment_mcd", opayment_mcd);
		pMap.put("ototal_price", ototal_price);
		pMap.put("ostatus_mcd", 0);
		
		try {
			session.update("HR_addPurchase", pMap);  // 프로시저 실행
			BigDecimal ordernoDecimal = (BigDecimal) pMap.get("orderno");  // BigDecimal로 캐스팅
			orderno = ordernoDecimal != null ? ordernoDecimal.intValue() : null;
			System.out.println("dao out orderno ->"+orderno);
			
			for (Purchase purchase : pList) {
				Map<String, Object> insertMap = new HashMap<>();
				
				insertMap.put("purchase", purchase);
				insertMap.put("memno", memno);
				insertMap.put("orderno", orderno);
				session.update("HR_processOrderProducts", insertMap);
			}
		} catch (Exception e) {
			log.error("kPurchase() error ->", e);
		}
		
		return orderno;
	}

	@Override
	public void updateKStatus(int orderno, String tid) {
		System.out.println("UserPurchaseServiceImp updateKStatus start ,,,");
		
		Map<String, Object> uMap = new HashMap<>();
		
		uMap.put("orderno", orderno);
		uMap.put("tid", tid);
		
		try {
			session.update("HR_updateKState", uMap);
		} catch (Exception e) {
			log.error("updateKStatus() error ->", e);
		}
	}
	
	
}
