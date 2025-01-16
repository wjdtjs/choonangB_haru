package com.example.haruProject.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
@AllArgsConstructor
public class Common {
	
	private int scd;
	private int bcd;
	private int mcd;
	private String content;
	private String bigo;
}
