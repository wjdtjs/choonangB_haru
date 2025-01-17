package com.example.haruProject.service.hr;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hr.BoardDao;
import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardServiceImp implements BoardService {
	
	private final BoardDao bd;

	// 게시글 내역
	@Override
	public int getTotalCnt(SearchItem si) {
		System.out.println("BoardServiceImp getTotalCnt() start ,,,");
		
		int totalCnt = bd.getTotalCnt(si);
		
		return totalCnt;
	}

	@Override
	public List<Board> boardList(int startRow, int endRow) {
		System.out.println("BoardServiceImp boardList() start ,,,");
		
		List<Board> bList = new ArrayList<>();
		
		bList = bd.boardList(startRow, endRow);
		
		return bList;
	}

	
	// 후기 상세
	// 게시글
	@Override
	public Board boardDetailContent(int bno) {
		System.out.println("BoardServiceImp boardDetailContent() start ,,,");
		System.out.println("bno ->"+bno);
		
		Board board = new Board();
		board = bd.boardDetailContent(bno);
		
		return board;
	}	
	// 댓글
	@Override
	public List<Board> boardDetailList(int bno) {
		System.out.println("BoardServiceImp boardDetailList() start ,,,");
		System.out.println("BoardServiceImp boardDetailList() bno ->"+bno);
		
		List<Board> bdList = new ArrayList<>();
		
		bdList = bd.boardDetailList(bno);
		
		return bdList;
	}

	// 후기 삭제
	@Override
	public int deleteBoard(int bno) {
		System.out.println("BoardServiceImp deleteBoard() start ,,,");
		System.out.println("BoardServiceImp deleteBoard() bno ->"+bno);
		
	
		int result = 0;
		result = bd.deleteBoard(bno);
		
		return result;
	}

	// 후기 댓글 삭제 -> 상태 비노출로 변경
	@Override
	public int deleteBoardRe(int bno) {
		System.out.println("BoardServiceImp deleteBoardRe() start ,,,");
		System.out.println("BoardServiceImp deleteBoardRe() bno ->"+bno);
		
		int result = 0;
		result = bd.deleteBoardRe(bno);
		
		return result;
	}

	

}
