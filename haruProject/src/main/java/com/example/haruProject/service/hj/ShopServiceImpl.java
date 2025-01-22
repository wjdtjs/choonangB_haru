package com.example.haruProject.service.hj;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.ShopDao;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Shop;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ShopServiceImpl implements ShopService{
	
	private final ShopDao sd;
	
	@Override
	public List<Shop> getShopList(int startRow, int endRow, SearchItem si) {
		System.out.println("ShopService getShopList");
		List<Shop> shopList = sd.getShopList(startRow,endRow,si);
		
		return shopList;
	}

	@Override
	public int getTotalCnt() {
		System.out.println("ShopService getTotalCnt");
		int totalCnt = sd.getTotalCnt();
		return totalCnt;
	}

}
