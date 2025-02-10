package com.example.haruProject.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Order {
	private int orderCnt;			// 상품종류
	private int orderno;			// 주문번호
	private Date odate;				// 주문날짜
	private int memno;				// 회원번호
	private String mtel;			// 전화번호
	private String mname;			// 회원명
	private int opayment_bcd;		// 결제 대분류
	private int opayment_mcd;		// 결제 중분류
	private String opayment_content;// 결제 방법
	private int ostatus_bcd;		// 주문상태 대분류
	private int ostatus_mcd;		// 주문상태 중분류
	private String ostatus_content; // 주문상태
	private Date update_date;		// 상태변경시간
	
	//orderProduct 테이블(orderno 외래키)
	private String pno;				//상품번호                  +++
	private int oquantity;			// 수량
	private int price;				// 가격
	
	private List<OrderProduct> productList; //
	
	// product 테이블(pno 외래키)
	private String pname;			// 상품이름
	private String pname1;			// 상품이름
	
	// 총구매금액
	private int totalPrice;
	
	// 카카오페이 결제 승인 고유번호
	private String tid;
}
