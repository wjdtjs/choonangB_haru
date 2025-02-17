package com.example.haruProject.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

// 예약

@Data
public class Appointment {
	private String resno;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date rdate;
	private String mcode;
	private int ano;
	private int memno;
	private int petno;
	private Date reg_date;
	private String memo;
	private String start_time;
	private int rtime;
	
	// 공통 테이블
	private int rstatus_bcd;
	private int rstatus_mcd;
	
	// join
	private String mname;		// 보호자 이름
	private String memail;		// 보호자 이메일
	private String petname;		// 동물 이름
	private String petimg;		// 동물 이미지
	private String aname;		// 주치의 이름
	private String item_bcd;	// 진료항목 대분류
	private String item;		// 진료 항목 이름
	private String status;		// 예약 상태
	private Date petbirth;		// 생일
	private String petheight;	// 몸길이
	private float petweight;	// 몸무게
	private String petspecial;	// 특이사항
	private String gender;		// 성별	
	private String species;		// 종
	private String cresno;		// 차트가 작성됐는지 확인하기 위함
	private String mtel;		// 보호자 전화 번호
	private String bresno;		// 후기가 작성됐는지 확인하기 위함
	private String cno;
	private int bno;
	
	// 검색
	private String start_date;	// 검색 시작 날짜
	private String end_date;	// 검색 끝 날짜
	
	// 추가
	private int mtitle_bcd;
	private int mtitle_mcd;
	private String rrdate;
	private String mitem;		// 대분류 content
	
	private int acount; 		// 예약 확정 수
}
