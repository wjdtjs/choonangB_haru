package com.example.haruProject.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Weight {

	private int memno;
	private int petno;
	private Date reg_date;
	private String petweight;
	
	private String rreg_date;
}
