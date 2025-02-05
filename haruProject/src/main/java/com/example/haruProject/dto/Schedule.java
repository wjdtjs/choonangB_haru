package com.example.haruProject.dto;

import java.util.Date;
import java.util.List;

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
	
	private String title;
	
	private Date nowoff;			// 현재 휴무일
	private Date newoff;			// 변경된 휴무일
	
	private List<Date> persoffdays; // 휴무일 리스트

}
