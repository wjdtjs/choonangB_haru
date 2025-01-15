package com.example.haruProject.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 페이지네이션을 위한 객체
 */
@Getter
@Setter
@ToString
public class Pagination {
	
	private int totalCnt; //전체 게시글 수
	private int currentPage; //현재 페이지
	private int startNum; //게시글 시작 번호
	private int blockSize; //한 페이지에서 보여줄 게시글 수
	private int pageCnt; //전체 페이지 수
	private int startPage; //시작 페이지
	private int endPage; //끝 페이지
	private int startRow; //시작 게시글
	private int endRow; //끝 게시글
	
	public Pagination(int totalCnt, String pageNum, int blockSize) {
		this.totalCnt = totalCnt;
		this.blockSize = blockSize;
		
		if(pageNum==null || pageNum.equals("")) {
			pageNum = "1";
		}
		
		this.currentPage = Integer.parseInt(pageNum);
		this.startRow = (currentPage - 1) * blockSize + 1;
		this.endRow   = startRow + blockSize - 1;  
		this.startNum = totalCnt - startRow + 1; 
		
		this.pageCnt = (int)Math.ceil((double)totalCnt/blockSize); 
		
		this.startPage = (int)(currentPage-1)/blockSize*blockSize + 1;
		
		this.endPage = startPage + blockSize - 1;
		
		if(endPage > pageCnt) endPage = pageCnt; //공갈 Page 방지
		
		
	}
	
}
