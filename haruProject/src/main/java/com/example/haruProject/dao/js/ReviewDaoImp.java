package com.example.haruProject.dao.js;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.BoardImg;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class ReviewDaoImp implements ReviewDao {
	
	private final SqlSession session;

	/**
	 * 커뮤니티 분류 조회
	 */
	@Override
	public List<Map<String, Object>> getMcdList() {
		List<Map<String, Object>> mList = new ArrayList<>();
		try {
			mList = session.selectList("JS_SelectBoardMcd");
		} catch (Exception e) {
			log.error("getMcdList() query error -> ", e);
		}
		
		System.out.println("커뮤니티 후기 분류 "+mList);
		
		return mList;
	}

	/**
	 * 커뮤니티 후기 수 조회
	 */
	@Override
	public int getReviewCnt(SearchItem si) {
		int totalCnt = 0;
		try {
			totalCnt = session.selectOne("JS_SelectReviewCnt", si);
		} catch (Exception e) {
			log.error("getReviewCnt() query error -> ", e);
		}
		
		return totalCnt;
	}

	/**
	 * 커뮤니티 후기 리스트 조회
	 * 필터적용
	 */
	@Override
	public List<Board> getReviewList(int startRow, int endRow, SearchItem si) {
		List<Board> bList = new ArrayList<>();
		
		Map<String, Object> rMap = new HashMap<>();
		rMap.put("startRow", startRow);
		rMap.put("endRow", endRow);
		rMap.put("si", si);
		
		try {
			bList = session.selectList("JS_SelectReviewList", rMap);
		} catch (Exception e) {
			log.error("getReviewList() query error -> ", e);
		}
		return bList;
	}

	/**
	 * 후기 상세 조회
	 */
	@Override
	public Board getBoardDetail(int bno) {
		Board board = new Board();
		try {
			board = session.selectOne("JS_SelectReviewDetail", bno);
		} catch (Exception e) {
			log.error("getBoardDetail() query error -> ", e);
		}
		
		return board;
	}

	/**
	 * 후기 이미지
	 */
	@Override
	public List<BoardImg> getBoardImg(int bno) {
		List<BoardImg> imgList = new ArrayList<>();
		try {
			imgList = session.selectList("JS_SelectReviewImgList", bno);
		} catch (Exception e) {
			log.error("getBoardImg() query error -> ", e);
		}
		
		return imgList;
	}

	/**
	 * 후기 댓글 전체 수
	 */
	@Override
	public int getCommentTotalCnt(int bno) {
		int totalCnt = 0;
		try {
			totalCnt = session.selectOne("JS_SelectCommentTotalCnt", bno);
		} catch (Exception e) {
			log.error("getCommentTotalCnt() query error -> ", e);
		}
		
		return totalCnt;
	}

	/**
	 * 후기 댓글 리스트
	 */
	@Override
	public List<Board> getCommentList(Pagination p, int bno) {
		List<Board> cList = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		map.put("p", p);
		map.put("bno", bno);
		
		try {
			cList = session.selectList("JS_SelectCommentList", map);
		} catch (Exception e) {
			log.error("getCommentList() query error -> ", e);
		}
		return cList;
	}

	/**
	 * 댓글 작성
	 */
	@Override
	public int writeComment(Board board) {
		int result = 0;
		try {
			session.update("JS_UpdateCommentShape", board);
			result = session.insert("JS_InsertComment", board);
		} catch (Exception e) {
			log.error("writeComment() query error -> ", e);
		}
		System.out.println("Dao writeComment() insert count : "+result);
		
		return result;
	}

	/**
	 * 후기 조회 수 증가
	 */
	@Override
	public void plusViewCount(int bno) {
		try {
			session.update("JS_UpdateReviewViewCnt", bno);
		} catch (Exception e) {
			log.error("plusViewCount() query error -> ", e);
		}
		
	}

	/**
	 * 후기 삭제
	 */
	@Override
	public void deleteReviews(int bno) {
		try {
			session.update("JS_UpdateReviewStatusDelete", bno);
		} catch (Exception e) {
			log.error("deleteReviews() query error -> ", e);
		}
		
	}

}
