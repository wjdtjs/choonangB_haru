package com.example.haruProject.dao.hr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class BoardDaoImp implements BoardDao {
	private final SqlSession session;
	
	@Override
	public int getTotalCnt(SearchItem si) {
		System.out.println("BoardDaoImp getTotalCnt start ,,,");
		int totalCnt = 0;
		
		try {
			totalCnt = session.selectOne("HR_SelectTotalBoardCnt", si);
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
	// 게시글
	@Override
	public Board boardDetailContent(int bno) {
		System.out.println("BoardDaoImp boardList start ,,,");
		
		Board board = new Board();
		
		try {
			board = session.selectOne("HR_SelectBoardDetailContent", bno);
		} catch (Exception e) {
			log.error("boardDetailList() error ->", e);
		}
		
		return board;
	}
	
	// 글 + 댓글
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
	

	// 후기 삭제
	@Override
	public int deleteBoard(int bno) {
		System.out.println("BoardDaoImp deleteBoard() start ,,,");
		System.out.println("BoardDaoImp deleteBoard() bno ->"+bno);
		
		int result = 0;
		
		try {
			result = session.delete("HR_DeleteBoard", bno);
			System.out.println("BoardDaoImp deleteBoard() result ->"+result);
		} catch (Exception e) {
			log.error("deleteBoard() error ->", e);
		}
		return result;
	}

	// 댓글 삭제 -> 상태 비노출로	
	@Override
	public int deleteBoardRe(int bno) {
		System.out.println("BoardDaoImp deleteBoardRe() start ,,,");
		System.out.println("BoardDaoImp deleteBoardRe() bno ->"+bno);
		
		int result = 0;
		
		try {
			result = session.update("HR_DeleteBoardRe", bno);
			System.out.println("BoardDaoImp deleteBoardRe() result ->"+result);
		} catch (Exception e) {
			log.error("deleteBoard() error ->", e);
		}
		return result;
	}
	
	

}
