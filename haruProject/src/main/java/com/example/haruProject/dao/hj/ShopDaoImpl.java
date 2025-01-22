package com.example.haruProject.dao.hj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Shop;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ShopDaoImpl implements ShopDao{
	
	private final SqlSession session;
	
	@Override
	public List<Shop> getShopList(int startRow, int endRow, SearchItem si) {
		System.out.println("ShopDao getShopList ...");
		List<Shop> shopList = new ArrayList<>();
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("startRow", startRow);
		paramMap.put("endRow", endRow);
		paramMap.put("search", si);
		try {
			shopList = session.selectList("HJSelectShopList",paramMap);
			System.out.println("ShopDao getShopList shopList"+shopList);
		} catch (Exception e) {
			System.out.println("ShopDao getShopList error->"+e.getMessage());
			
		}
		return shopList;
	}

	@Override
	public int getTotalCnt() {
		int result = 0;
		try {
			result = session.selectOne("HJTotalCnt");
			System.out.println("ShopDao getShopList result -> "+result);
		} catch (Exception e) {
			System.out.println("ShopDao getTotalCnt error->"+e.getMessage());
		}
		return result;
	}

}
