package com.example.haruProject.service.js;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.js.ShopDao;
import com.example.haruProject.dto.Board;
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
	 * 상품 상태 공통 데이터 리스트
	 * @return 상태 공통 데이터 리스트
	 */
	@Override
	public List<Map<String, Object>> getStatusList() {
		log.info("getStatusList() start..");
		List<Map<String, Object>> statusList = new ArrayList<>();
		
		statusList = sd.getStatusList();
		
		return statusList;
	}

	/**
	 * 상품 분류 공통데이터 대분류 리스트
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getBCDList() {
		log.info("getBCDList() start..");
		List<Map<String, Object>> bcdList = new ArrayList<>();
		
		bcdList = sd.getBCDList();
		
		return bcdList;
	}

	/**
	 * 상품 분류 공통데이터 중분류 리스트
	 * @param bcd 대분류 값
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getMCDList(int bcd) {
		log.info("getMCDList() start..");
		List<Map<String, Object>> mcdList = new ArrayList<>();
		
		mcdList = sd.getMCDList(bcd);
		
		return mcdList;
	}

	/**
	 * 상품 등록
	 * @param pd 등록상품 객체
	 * @retur
	 */
	@Override
	public void uploadProduct(Product pd) {
		log.info("uploadProduct() start..");	
		sd.uploadProduct(pd);
	}

	/**
	 * 상품 상세 조회
	 */
	@Override
	public Product getProductDetail(String pno) {
		log.info("getProductDetail() start..");
		
		Product pd = new Product();
		pd = sd.getProductDetail(pno);
		
		return pd;
	}

	/**
	 * 상품 수정
	 * @param pd 수정상품 객체
	 */
	@Override
	public void updateProduct(Product pd, boolean img_change) {
		log.info("updateProduct() start..");
		sd.updateProduct(pd, img_change);
	}


	/**
	 * 쇼핑카트에 담아둔 상품 수
	 * @param memno 사용자 번호
	 */
	@Override
	public int getCartCount(int memno) {
		log.info("getCartCount() start..");
		
		int count = sd.getCartCount(memno);
		return count;
	}


	/**
	 * 분류 필터 적용된 상품 리스트 수
	 */
	@Override
	public int getCDProductCnt(SearchItem si) {
		log.info("getCDProductCnt() start..");
		
		int count = sd.getCDProductCnt(si);
		return count;
	}


	/**
	 * 분류 필터 적용된 상품 리스트 조회
	 */
	@Override
	public List<Product> cdProductList(int startRow, int endRow, SearchItem si) {
		log.info("cdProductList() start..");
		
		List<Product> pList = new ArrayList<>();
		
		pList = sd.cdProductList(startRow, endRow, si);
		
		return pList;
	}


	/**
	 * 상품 후기 조회
	 */
	@Override
	public List<Board> productReviewList(int startRow, int endRow, int pno) {
		log.info("productReviewList() start..");
		
		List<Board> rList = new ArrayList<>();
		rList = sd.productReviewList(startRow, endRow, pno);
		
		return rList;
	}


	/**
	 * 해당 상품후기 전체 수
	 */
	@Override
	public int getProductReviewTotCnt(int pno) {
		log.info("getProductReviewTotCnt() start..");
		
		int count = sd.getProductReviewTotCnt(pno);
		return count;
	}

	
}
