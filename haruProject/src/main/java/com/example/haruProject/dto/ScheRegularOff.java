package com.example.haruProject.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ScheRegularOff {
	private int ano;				
	private Date nowoff;			// 현재 휴무일
	private Date newoff;			// 변경된 휴무일
	
	private List<Date> persoffdays; // 휴무일 리스트

}
