package com.example.haruProject.dto;

import lombok.Data;

@Data
public class ReadyResponse {
	// 카카오페이 dto
	
	private String tid;						 // 결제 고유번호
	private String next_redirect_pc_url;	 // 카카오톡으로 결제 요청 메시지(TMS)를 보내기 위함 (pc웹일 경우)
	private String next_redirect_mobile_url; // 모바일 웹일 경우
	private int orderno;
}
