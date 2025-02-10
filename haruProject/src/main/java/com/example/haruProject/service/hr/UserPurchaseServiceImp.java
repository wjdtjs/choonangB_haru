package com.example.haruProject.service.hr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hr.UserPurchaseDao;
import com.example.haruProject.dto.Purchase;
import com.example.haruProject.dto.ShoppingCart;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserPurchaseServiceImp implements UserPurchaseService {
	private final UserPurchaseDao pd;

	// 장바구니 리스트 불러오기
	@Override
	public List<ShoppingCart> getShoppingCartList(int memno) {
		System.out.println("UserPurchaseServiceImp getShoppingCartList() start ,,,");
		System.out.println("UserPurchaseServiceImp getShoppingCartList() memno ->"+memno);
		
		List<ShoppingCart> sList = pd.getShoppingCartList(memno);

		return sList;
	}

	// 수량 변경에 따른 squantity 값 업데이트
	@Override
	public void updateSquantity(int pno, int squantity, int memno) {
		System.out.println("UserPurchaseServiceImp updateSquantity() start ,,,");
		System.out.println("UserPurchaseServiceImp updateSquantity() pno ->"+pno);
		System.out.println("UserPurchaseServiceImp updateSquantity() squantity ->"+squantity);
		System.out.println("UserPurchaseServiceImp updateSquantity() memno ->"+memno);
		
		pd.updateSquantity(pno, squantity, memno);
	}

	// 장바구니 품목 삭제
	@Override
	public void deleteSP(int memno, int pno) {
		System.out.println("UserPurchaseServiceImp deleteSP() start ,,,");
		System.out.println("UserPurchaseServiceImp deleteSP() memno ->"+memno);
		System.out.println("UserPurchaseServiceImp deleteSP() pno ->"+pno);
		
		pd.deleteSP(memno, pno);		
	}

	// 선택된 주문 상품 정보 불러오기
	@Override
	public List<ShoppingCart> getorderList(int memno, List<Integer> pnoList) {
		System.out.println("UserPurchaseServiceImp getorderList() start ,,,");
		System.out.println("UserPurchaseServiceImp getorderList() memno ->"+memno);
		System.out.println("UserPurchaseServiceImp getorderList() pnoList ->"+pnoList);
		
		List<ShoppingCart> sList = pd.getorderList(memno, pnoList);
		
		return sList;
	}

	// 주문
	@Override
	public int skPurchase(List<Purchase> pList, int memno, int opayment_mcd, int ototal_price) {
		System.out.println("UserPurchaseServiceImp storePurchase() start ,,,");
		System.out.println("UserPurchaseServiceImp storePurchase() pList ->"+pList);
		System.out.println("UserPurchaseServiceImp storePurchase() memno ->"+memno);
		
		
		int orderno = 0;
		
		if (opayment_mcd == 300) {
			// 카카오페이
			orderno = pd.kPurchase(pList, memno, opayment_mcd, ototal_price);
		} else if (opayment_mcd == 400) {
			// 매장결제
			orderno = pd.sPurchase(pList, memno, opayment_mcd, ototal_price);			
		}
		
		return orderno;
	}

	// 카카오페이 > 결제 성공시 주문상태 100으로 update
	@Override
	public void updateKStatus(int orderno, String tid) {
		System.out.println("UserPurchaseServiceImp updateStatus start ,,,");
		System.out.println("UserPurchaseServiceImp updateStatus orderno ->"+orderno);
		System.out.println("UserPurchaseServiceImp updateStatus tid ->"+tid);
		
		pd.updateKStatus(orderno, tid);
	}
}
