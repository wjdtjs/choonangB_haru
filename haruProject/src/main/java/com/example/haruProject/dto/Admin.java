package com.example.haruProject.dto;


import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
@AllArgsConstructor
public class Admin {
	private int ano;			//사번
	private String apasswd;		//비빌번호
	private String re_apasswd;	//비빌번호 재입력
	private String atel;		//전화번호
	private String aemail;		//이메일
	private String aname;		//이름
	private Date hiredate;		//입사일
	private Date reg_date;		//등록일
	private int alevel_bcd;		//Role 대분류
	private int alevel_mcd;		//Role 중분류
	private int astatus_bcd;	//상태 대분류
	private int astatus_mcd;	//상태 중분류
	
	// 공통테이블
	private int bcd;
	private int mcd;
	private int alevelMcd;
	private int astatusMcd;
	
	private String level_content;
	private String status_content;
	
	public Admin(int ano, String apasswd) {
		this.ano = ano;
		this.apasswd = apasswd;
	}
}
