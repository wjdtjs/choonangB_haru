package com.example.haruProject.dto;

import java.util.Date;

import lombok.Data;

// 예약

@Data
public class Appointment {
	private String resno;
	private Date rdate;
	private String mcode;
	private int anl;
	private int memno;
	private int pno;
	private Date reg_date;
	private long memo;
	private String start_time;
	private String end_time;
	
	// 공통 테이블
	private int rstatus_bcd;
	private int rstatus_mcd;
	
	// join
	private String mname;		// 보호자 이름
	private String petname;		// 동물 이름
	private String aname;		// 주치의 이름
	private String item;		// 진료 항목 이름
	private String status;		// 예약 상태
	
	private String species;		// 종
	private String cresno;		// 차트가 작성됐는지 확인하기 위함
	
}
