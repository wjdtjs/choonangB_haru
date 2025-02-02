package com.example.haruProject.service.hr;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hr.UserPurchaseDao;
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
}
