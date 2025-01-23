package com.example.haruProject.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@RequiredArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class AgreementTerms {
	
	//약관동의 여부
	private boolean usage; 		//이용약관
	private boolean personal; 	//개인정보수집및이용
	private boolean marketing; 	//정보수신
}
