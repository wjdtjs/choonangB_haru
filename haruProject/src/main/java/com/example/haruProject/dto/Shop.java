package com.example.haruProject.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Shop {
	
	private int orderno;			// 주문번호
	private Date odate;				// 주문날짜
	private int memno;				// 회원번호
	private String mname;			// 회원명
	private int opayment_bcd;		// 결제 대분류
	private int opayment_mcd;		// 결제 중분류
	private String opayment_content;// 결제 방법
	private int ostatus_bcd;		// 주문상태 대분류
	private int ostatus_mcd;		// 주문상태 중분류
	private String ostatus_content; // 주문상태
	private Date update_date;			// 상태변경시간
	private String pname;

}
