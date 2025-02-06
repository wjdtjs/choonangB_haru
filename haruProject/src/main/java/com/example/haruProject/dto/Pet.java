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
	private Double petweight;	// 몸무게
	private String petspecial;	// 특이사항
	private String petimg;		// 프로필이미지
	private int ano;			// 주치의번호
	private String gender;		// 성별
	private String species1;	// 종 대문류
	private String species2;	// 종 중분류
	private String species;		// 종
	private String status;		// 상태
	private int petgender_bcd;
	private int petgender_mcd; 	// 성별 중분류
	private int petstatus_bcd;
	private int petstatus_mcd;
	private int petspecies_bcd;
	private int petspecies_mcd;
	
	private int bcd;
	private int mcd;
	private int scd;

	// add pet
	private String gender1;		// 성별
	private String gender2;		// 중성화 여부
	
	// edit pet
	private String fpetbirth;
}
