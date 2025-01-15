package com.example.haruProject.controller.admin.js;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Product;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.js.ShopService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class ShopController {
	
	private final ShopService ss;
	
	/**
	 * 상품 목록 조회
	 * @param pageNum 현재 페이지
	 * @param blockSize 한페이지에서 볼 게시글 수
	 * @return
	 */
	@GetMapping("/api/product-list")
	public Map<String, Object> productList(@RequestParam(value = "pageNum", required = true) String pageNum,
            						 @RequestParam(value = "blockSize", required = false, defaultValue="10") String blockSize,
            						 @RequestParam(value = "search1", required = false) String search1,
            						 @RequestParam(value = "search2", required = false) String search2
            						 ) 
	{
		log.info("productList() start..");
		List<Product> pList = new ArrayList<>();
		Map<String, Object> pListMap = new HashMap<>();
				
		//검색 필터
		SearchItem si = new SearchItem(search1, search2);
		
		//상품 전체 수 (필터 적용)
		int totalCnt = ss.getTotalCnt(si);
		
		//페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize)); 
		
		//페이지네이션 적용된 상품 목록		
		pList = ss.productList(pagination.getStartRow(), pagination.getEndRow(), si);
//		System.out.println(pList);
		
		pListMap.put("pagination", pagination);
		pListMap.put("list", pList);
		
//		System.out.println(pList);

		return pListMap;
		
	}
	
	/**
	 * 상품 분류 공통데이터 리스트 조회
	 * @return
	 */
	@GetMapping("/api/product-cd")
	public List<Map<String, Object>> productCD() {
		log.info("productCD() start..");
		
		List<Map<String, Object>> cdList = new ArrayList<>();
		cdList = ss.getCDList();
		
		System.out.println(cdList);
		
		return cdList;
	}

	
	
}
