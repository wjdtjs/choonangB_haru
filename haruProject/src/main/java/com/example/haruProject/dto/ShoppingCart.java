package com.example.haruProject.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ShoppingCart {
	private int memno;
	private int pno;
	private Date reg_date;
	private int squantity;
	
	// product
	private String pname;
	private int pprice;
	private String pimg_main;
	private String pbrand;
	private int pquantity;
	private int pstatus_mcd;
}
