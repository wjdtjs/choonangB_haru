package com.example.haruProject.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class Pet {
	private int memno;			// 회원 번호
	private int petno;			// 동물 번호
	private String petname;		// 동물 이름
	private Date petbirth;		// 생일
	private String petheight;	// 몸길이
	private float petweight;	// 몸무게
	private String petspecial;	// 특이사항
	private String petimg;		// 프로필이미지
	private int ano;			// 주치의번호
	private String gender;		// 성별
	private String species1;	// 종 대문류
	private String species2;	// 종 중분류
	private String status;		// 상태
	

}
