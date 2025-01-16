package com.example.haruProject.dao.hr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class BoardDaoImp implements BoardDao {
	private final SqlSession session;
	
	@Override
	public int getTotalCnt() {
		System.out.println("BoardDaoImp getTotalCnt start ,,,");
		int totalCnt = 0;
		
		try {
			totalCnt = session.selectOne("HR_SelectTotalBoardCnt");
		} catch (Exception e) {
			log.error("getTotalCnt() error ->", e);
		}
		return totalCnt;
	}

	@Override
	public List<Board> boardList(int startRow, int endRow) {
		System.out.println("BoardDaoImp boardList start ,,,");
		List<Board> blist = new ArrayList<>();
		
		Map<String, Object> bMap = new HashMap<>();
		
		bMap.put("startRow", startRow);
		bMap.put("endRow", endRow);
		
		try {
			blist = session.selectList("HR_SelectBoardList", bMap);
		} catch (Exception e) {
			log.error("boardList() error ->", e);
		}
		
		System.out.println("blist" + blist);
		return blist;
	}

	
	// 후기 상세
	@Override
	public List<Board> boardDetailList(int bno) {
		List<Board> bdlist = new ArrayList<>();
		
		Map<String, Object> bdMap = new HashMap<>();
		
		bdMap.put("bno", bno);
		
		try {
			bdlist = session.selectList("HR_SelectBoardDetailList", bdMap);
			System.out.println("bdlist ->" + bdlist);
		} catch (Exception e) {
			log.error("boardDetailList() error ->", e);
		}
		
		return bdlist;
	}

}
