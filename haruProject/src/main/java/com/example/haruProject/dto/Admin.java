package com.example.haruProject.dto;


import java.util.Date;

import lombok.Data;

@Data
public class Admin {
	private int ano;
	private String apasswd;
	private String atel;
	private String aemail;
	private String aname;
	private Date hiredate;
	private int alevel_bcd;
	private int alevel_mcd;
	private int astatus_bcd;
	private int astatus_mcd;
	
	// 공통테이블
	private String alevel;
	private String astatus;
}
