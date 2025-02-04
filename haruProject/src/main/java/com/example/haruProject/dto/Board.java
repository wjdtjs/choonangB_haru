package com.example.haruProject.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Board {
	private int bno;			// 글 번호 (idx)
	private String btitle;		// 글 제목
	private String bcontents;	// 글 내용
	private int bview_count;	// 조회수
	private String bimg;			// 이미지
	
	private int bgroup;			// 그룹
	private int bseq;			// 순서
	private int blevel;			// 들여쓰기
	
	private Date reg_date;		// 작성일
	private Date update_date;	// 수정일
	
	private int board_type_bcd;	// 후기분류-대분류
	private int board_type_mcd;	// 후기분류-중분류
	private int bstatus_bcd;	// 상태-대분류
	private int bstatus_mcd;	// 상태-중분류
	
	private String resno;		// 예약번호
	private int orderno;		// 주문번호
	private String pno;			// 상품번호
	private int memno;			// 작성자
	private String mname;
	private String mid;
	private String memail;
	
	// 조회용
	private String content;	    // 공통코드 가져올 때
	private String item;
	private int re_count = 0;	// 댓글 수 -> 댓글이 없을 경우에 null이 들어오지 않게 기본값 0 설정해둠!
	
	private String otitle; 		// 해당 댓글이 달린 원글의 제목
}
