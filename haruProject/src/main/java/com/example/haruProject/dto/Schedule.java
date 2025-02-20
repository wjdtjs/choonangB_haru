package com.example.haruProject.dto;

import java.util.Date;
import java.util.List;

import jakarta.mail.internet.ParseException;
import lombok.Data;

@Data
public class Schedule {
	private int schno;
	private Date schdate;
	private Date reg_date;
	private Date update_date;
	private int ano;
	private int schtype_bcd;
	private int schtype_mcd;
	
	// common Join
	private String sch_content;
	
	// admin Join
	private String aname;
	
	// 정기휴무
	private Date newoff;			// 변경된 휴무일
	private List<String> persoffdays; // 휴무일 리스트
	
	// 
	private String offday1;
	private String offday2;
	
}
