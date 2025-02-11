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

	private String search1;
	private String search2;
	private String search3;
	
	private int type4 = 0;
	private int type5 = 0;
	private int search4 = 0;
	
	private String start_date;
	private String end_date;
	
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
	
	public SearchItem(String search1, int search4) {
		this.search1 = search1;
		this.search4 = search4;
	}
	
	public SearchItem(int type4) {
		this.type4 = type4;
	}
	
	public SearchItem(int type4, int type5, String search1, String start_date, String end_date) {
		this.type4 = type4;
		this.type5 = type5;
		this.search1 = search1;
		this.start_date = start_date;
		this.end_date = end_date;
	}

	public SearchItem(int type4, int type5, String search1, String start_date, String end_date, int search4) {
		this.type4 = type4;
		this.type5 = type5;
		this.search1 = search1;
		this.start_date = start_date;
		this.end_date = end_date;
		this.search4 = search4;
	}
	
	public SearchItem(int type4, int type5, int search4) {
	    this.type4 = type4;
	    this.type5 = type5;
	    this.search4 = search4;
	}
	

}