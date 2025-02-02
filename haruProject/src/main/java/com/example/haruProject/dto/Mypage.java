package com.example.haruProject.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Mypage {
	
	private String petname;
	private String species;		// 동물 종 (petspecies_bcd, mcd로 common의 content 값 불러오기)
	private Date petbirth;
	private String petimg;
	private String gender;		// 동물 성별 (petgender_bcd, mcd로 common의 content 값 불러오기)

}
