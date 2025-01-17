package com.example.haruProject.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Consultation {
	private String cno;			// 차트번호		
	private Date reg_date;		// 작성날짜
	private String ccontent;	// 차트내용
	private String cent_con;	// 기타전달사항
	private String update_date; // 수정일
	private String resno;		// 예약번호 외래키
	private String img1;		// 이미지(1~5)
	private String img2;
	private String img3;
	private String img4;
	private String img5;
}
