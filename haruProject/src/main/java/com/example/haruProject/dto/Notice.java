package com.example.haruProject.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@RequiredArgsConstructor
@AllArgsConstructor
public class Notice {
	private int nno;			//공지사항번호
	private String ntitle;		//제목
	private String ncontents;	//내용
	private int nview_count;	//조회수
	private int nstatus_bcd;	//상태 대분류
	private int nstatus_mcd;	//상태 중분류
	private int ano;			//작성한 관리자pin
	private Date update_date;	//수정일
	private Date reg_date;		//등록일
	
	private String status;		//상태
	private String aname;		//작성한 관리자 이름
	private boolean istop;		//상단고정여부
	private boolean isvisible;	//노출여부
}
