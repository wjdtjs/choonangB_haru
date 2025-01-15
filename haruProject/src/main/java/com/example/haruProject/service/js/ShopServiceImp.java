package com.example.haruProject.service.js;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.js.ShopDao;
import com.example.haruProject.dto.Product;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ShopServiceImp implements ShopService {

	private final ShopDao sd;
	
	/**
	 * 전체 상품 개수
	 * @return 상품 개수
	 */
	@Override
	public int getTotalCnt(SearchItem si) {
		log.info("getTotalCnt() start..");
		
		int totalCnt = sd.getTotalCnt(si);
				
		return totalCnt;
	}
	


	/**
	 * 상품 리스트 조회
	 * @return 상품 리스트
	 */
	@Override
	public List<Product> productList(int startRow, int endRow, SearchItem si) {
		log.info("productList() start..");
		
		List<Product> pList = new ArrayList<>();
		
		pList = sd.productList(startRow, endRow, si);
		
		return pList;
	}


	/**
	 * 
	 * @return 상태 공통 데이터 리스트
	 */
	@Override
	public List<Map<String, Object>> getStatusList() {
		log.info("getStatusList() start..");
		List<Map<String, Object>> statusList = new ArrayList<>();
		
		statusList = sd.getStatusList();
		
		return statusList;
	}



	@Override
	public List<Map<String, Object>> getCDList() {
		log.info("getCDList() start..");
		List<Map<String, Object>> cdList = new ArrayList<>();
		
		cdList = sd.getCDList();
		return cdList;
	}

	
}
