package com.example.haruProject.dao.hr;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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
}
