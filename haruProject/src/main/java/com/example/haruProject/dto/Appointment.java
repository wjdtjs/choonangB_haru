package com.example.haruProject.dto;

import java.util.Date;

import lombok.Data;

// 예약

@Data
public class Appointment {
	private String resno;
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
	private String petname;		// 동물 이름
	private String aname;		// 주치의 이름
	private String item;		// 진료 항목 이름
	private String status;		// 예약 상태
	private Date petbirth;		// 생일
	private float petweight;	// 몸무게
	private String petspecial;	// 특이사항
	private String gender;		// 성별	
	private String species;		// 종
	private String cresno;		// 차트가 작성됐는지 확인하기 위함
	
	// 검색
	private String start_date;	// 검색 시작 날짜
	private String end_date;	// 검색 끝 날짜
	
}
