package com.example.haruProject.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 상품
 */
@Getter
@Setter
@ToString
@RequiredArgsConstructor
@AllArgsConstructor
public class Product {
	private int pno;			//상품번호
	private String pname;		//상품명
	private int pprice;			//상품가격
	private String pbuy_store;	//구매
	private String pimg_main;	//메인이미지
	private String pbrand;		//브랜드
	private String pdetails;	//상세설명
	private int pquantity;		//수량
	private int ano;			//등록 관리자 사번
	private int pstatus_bcd;	//상태
	private int pstatus_mcd;	//상태 대분류
	private int pstep_bcd;		//상품분류
	private int pstep_mcd;		//상품분류_대분류
	private Date update_date;	//수정일
	private Date reg_date;		//등록일
	
	private String status;

	
}
