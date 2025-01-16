package com.example.haruProject.dao.js;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Product;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class ShopDaoImp implements ShopDao {

//	private static ShopDaoImp instance;
//	private ShopDaoImp() {}
//	
//	/**
//	 * DAO의 instance 만들기 
//	 * @return
//	 */
//	public static ShopDaoImp getInstance() {
//		if(instance == null) {
//			instance = new ShopDaoImp();
//		}
//		return instance;
//	}
	
	private final SqlSession session;
	
	
	/**
	 * 상품 목록 전체 수 가져오기
	 * @return
	 */
	public int getTotalCnt(SearchItem si) {
		int totalCnt = 0;
		
		try {
			totalCnt = session.selectOne("JS_SelectTotalProductCnt", si);
		} catch (Exception e) {
			log.error("getTotalCnt() query error -> {}", e.getMessage());
		}
				
		return totalCnt;
	}
	
	/**
	 * 상품 목록 가져오기 (페이지네이션)
	 * @param startRow	첫 게시글
	 * @param endRow	마지막 게시글 
	 * @param si		검색필터
	 * @return
	 */
	public List<Product> productList(int startRow, int endRow, SearchItem si) {
		List<Product> list = new ArrayList<>();
		
		Map<String, Object> parameterMap = new HashMap<>();
		parameterMap.put("startRow", startRow);
		parameterMap.put("endRow", endRow);
		parameterMap.put("search", si);
		
		try {
			list = session.selectList("JS_SelectProductList", parameterMap);
			
		} catch (Exception e) {
			log.error("productList() query error -> {}", e.getMessage());
		}
		
		return list;
	}

	/**
	 * 상품 상태 공통데이터 리스트
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getStatusList() {
		List<Map<String, Object>> list = new ArrayList<>();
		
		try {
			list = session.selectList("JS_SelectCommonStatus");
		} catch (Exception e) {
			log.error("getStatusList() query error -> {}", e.getMessage());
		}
		
		return list;
	}

	/**
	 * 상품 분류 공통데이터 대분류 리스트
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getBCDList() {
		List<Map<String, Object>> list = new ArrayList<>();
		
		try {
			list = session.selectList("JS_SelectProductBCD");
		} catch (Exception e) {
			log.error("getBCDList() query error -> {}", e.getMessage());
		}
		
		return list;
	}

	/**
	 * 상품 분류 공통데이터 중분류 리스트
	 * @parama bcd 대분류 값
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getMCDList(int bcd) {
		List<Map<String, Object>> list = new ArrayList<>();
		
		try {
			list = session.selectList("JS_SelectProductMCD", bcd);
		} catch (Exception e) {
			log.error("getMCDList() query error -> {}", e.getMessage());
		}
		
		return list;
	}

	/**
	 * 상품 등록
	 * @param pd 상품 객체
	 */
	@Override
	public void uploadProduct(Product pd) {
		try {
			session.insert("JS_InsertProduct", pd);
		} catch (Exception e) {
			log.error("uploadProduct() query error -> {}", e.getMessage());
		}
		
	}

	/**
	 * 상품 상세 조회
	 */
	@Override
	public Product getProductDetail(String pno) {
		Product pd = new Product();
		try {
			pd = session.selectOne("JS_SelectProductDetail", pno);
		} catch (Exception e) {
			log.error("getProductDetail() query error -> {}", e.getMessage());
		}
		
		return pd;
	}

	/**
	 * 상품 수정
	 * @param pd 수정상품 객체
	 */
	@Override
	public void updateProduct(Product pd) {
		try {
			session.insert("JS_UpdateProduct", pd);
		} catch (Exception e) {
			log.error("updateProduct() query error -> {}", e.getMessage());
		}
		
	}
}
