package com.example.haruProject.service.hr;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hr.BoardDao;
import com.example.haruProject.dto.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardServiceImp implements BoardService {
	
	private final BoardDao bd;

	// 게시글 내역
	@Override
	public int getTotalCnt() {
		System.out.println("BoardServiceImp getTotalCnt() start ,,,");
		
		int totalCnt = bd.getTotalCnt();
		
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
	@Override
	public List<Board> boardDetailList(int bno) {
		System.out.println("BoardServiceImp boardDetailLis() start ,,,");
		
		List<Board> bdList = new ArrayList<>();
		
		bdList = bd.boardDetailList(bno);
		
		return bdList;
	}

}
