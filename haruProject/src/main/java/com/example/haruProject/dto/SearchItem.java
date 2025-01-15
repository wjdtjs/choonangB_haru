package com.example.haruProject.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@RequiredArgsConstructor
public class SearchItem {
	
	private String type1;
	private String type2;
	private String type3;
	private String search1;
	private String search2;
	private String search3;
	
	public SearchItem(String search1) {
		this.search1 = search1;
	}
	
	public SearchItem(String search1, String search2) {
		this.search1 = search1;
		this.search2 = search2;
	}
	
	public SearchItem(String type1, String search1, String search2) {
		this.search1 = search1;
		this.search2 = search2;
		this.type1 = type1;
	}
}
