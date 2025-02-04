package com.example.haruProject.service.js;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.js.ReviewDao;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.BoardImg;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Product;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReviewServiceImp implements ReviewService {
	
	private final ReviewDao rd;
	
	/**
	 * 커뮤니티 분류 조회 (수술, 진료)
	 */
	@Override
	public List<Map<String, Object>> getMcdList() {
		
		List<Map<String, Object>> mList = new ArrayList<>();
		mList = rd.getMcdList();
		return mList;
	}

	/**
	 * 커뮤니티 후기 수
	 */
	@Override
	public int getReviewCnt(SearchItem si) {
		int totalCnt = rd.getReviewCnt(si);
		return totalCnt;
	}

	/**
	 * 커뮤니티 후기 리스트 
	 * 필터적용
	 */
	@Override
	public List<Board> getReviewList(int startRow, int endRow, SearchItem si) {
		List<Board> bList = new ArrayList<>();
		bList = rd.getReviewList(startRow, endRow, si);
		return bList;
	}

	/**
	 * 후기 상세 조회
	 */
	@Override
	public Board getBoardDetail(int bno) {
		Board board = new Board();
		board = rd.getBoardDetail(bno);
		return board;
	}

	/**
	 * 후기 이미지 조회
	 */
	@Override
	public List<BoardImg> getBoardImg(int bno) {
		List<BoardImg> imgList = new ArrayList<>();
		imgList = rd.getBoardImg(bno);
		
		return imgList;
	}

	/**
	 * 후기 댓글 전체 수
	 */
	@Override
	public int getCommentTotalCnt(int bno) {
		int totalCnt = rd.getCommentTotalCnt(bno);
		return totalCnt;
	}

	/**
	 * 후기 댓글 리스트
	 */
	@Override
	public List<Board> getCommentList(Pagination p, int bno) {
		List<Board> cList = new ArrayList<>();
		cList = rd.getCommentList(p, bno);
		return cList;
	}

	/**
	 * 후기 댓글 쓰기
	 */
	@Override
	public int writeComment(Board board) {
		int result = rd.writeComment(board);
		return result;
	}

	/**
	 * 후기 조회수 증가
	 */
	@Override
	public void plusViewCount(int bno) {
		log.info("plusViewCount Service start..");
		rd.plusViewCount(bno);
	}

	/**
	 * 후기 삭제
	 */
	@Override
	public void deleteReviews(int bno) {
		rd.deleteReviews(bno);
		
	}

	/**
	 * 예약 상세
	 */
	@Override
	public Appointment getAppointment(String resno) {
		Appointment appointment = new Appointment();
		appointment = rd.getAppointment(resno);
		return appointment;
	}

	/**
	 * 후기 작성
	 */
	@Override
	public void writeReview(Board board, List<String> imgPathList) {
		rd.writeReview(board, imgPathList);
		
	}


}
