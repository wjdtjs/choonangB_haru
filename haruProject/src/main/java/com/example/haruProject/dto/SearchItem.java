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
	
	private int type4 = 0;
	private int type5 = 0;
	
	public SearchItem(String search1) {
		this.search1 = search1;
	}
	
	public SearchItem(String search1, String search2) {
		this.search1 = search1;
		this.search2 = search2;
	}
	
	public SearchItem(int type4, String search1) {
		this.type4 = type4;
		this.search1 = search1;
	}
	
	public SearchItem(int type4, int type5, String search1) {
		this.type4 = type4;
		this.type5 = type5;
		this.search1 = search1;
	}
}
