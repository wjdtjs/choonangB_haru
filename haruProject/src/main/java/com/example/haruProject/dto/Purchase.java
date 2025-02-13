package com.example.haruProject.dto;

import lombok.Data;

@Data
public class Purchase {
	private int memno;
	private int pno;
	private int squantity;
	private int pprice;
	private int opayment_mcd;
	private int ototal_price;
	private String pname;
	private int orderno;
	
	private int dp; // direct_purchase
}
