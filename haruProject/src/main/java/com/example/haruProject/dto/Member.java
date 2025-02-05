package com.example.haruProject.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
public class Member {
	private int memno;
	private String mid;
	private String mpasswd;
	private String re_mpasswd;
	private String mname;
	private String mtel;
	private String memail;
	private Date reg_date;		// 등록일
	private Date update_date;	// 수정일
	private int mstatus_bcd;	// 상태 대분류
	private int mstatus_mcd;	// 상태 중분휴
	private int is_agree;		// 동의 여부
	private Date agree_date;	// 동의 날짜
	private String authcode; 	// 인증코드
	private Long valid_time; 	// 유효시간
	
	// 공통테이블
	private String mstatis_content;
	
	// 조회용
	private String search1;			private String keyword;

	public Member(String memail, String mpasswd) {
		this.memail = memail;
		this.mpasswd = mpasswd;
	}
	
	public Member(String memail, String mid, String mname) {
		this.memail = memail;
		this.mid = mid;
		this.mname = mname;
	}
	
}
