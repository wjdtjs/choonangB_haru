package com.example.haruProject.dao.js;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.BoardImg;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.SearchItem;

public interface ReviewDao {

	List<Map<String, Object>> getMcdList();
	int getReviewCnt(SearchItem si);
	List<Board> getReviewList(int startRow, int endRow, SearchItem si);
	Board getBoardDetail(int bno);
	List<BoardImg> getBoardImg(int bno);
	int getCommentTotalCnt(int bno);
	List<Board> getCommentList(Pagination p, int bno);
	int writeComment(Board board);
	void plusViewCount(int bno);
	void deleteReviews(int bno);

}
