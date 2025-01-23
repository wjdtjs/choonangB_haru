package com.example.haruProject.dto;

import java.util.Date;

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
}
