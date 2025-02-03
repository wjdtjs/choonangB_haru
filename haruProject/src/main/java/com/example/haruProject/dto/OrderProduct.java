package com.example.haruProject.dto;

import lombok.Data;

@Data
public class OrderProduct {
	
	private int orderno;			// 주문전호
	private String pno;				//상품번호
	private int oquantity;			// 수량
	private int pprice;				// 가격
	
	private String pname;			// 상품명
	private String pimg_main;		// 이미지
	private String pbrand;			// 브랜드
	
	private int totalPrice;			// 총구매금액
	
	private int bno;				// 리뷰 작성여부
}
