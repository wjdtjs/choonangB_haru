package com.example.haruProject.dto;

import lombok.Data;

@Data
public class OrderProdct {
	
	private int orderno;			// 주문전호
	private String pno;				//상품번호
	private int oquantity;			// 수량
	private int pprice;				// 가격
	
	private String pname;			// 주문자이름
	
	private int totalPrice;			// 총구매금액
}
