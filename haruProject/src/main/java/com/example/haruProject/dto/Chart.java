package com.example.haruProject.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data

public class Chart {
	private String cno;			// 차트번호		
	private Date reg_date;		// 작성날짜
	private String ccontents;	// 차트내용
	private String cect_con;	// 기타전달사항
	private String update_date; // 수정일
	private String resno;		// 예약번호 외래키
	
	private int [] imgno;	// 후기 - 삭제할 이미지 번호
}
