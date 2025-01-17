package com.example.haruProject.service.hr;

import java.util.List;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.SearchItem;

public interface BoardService {

	int getTotalCnt(SearchItem si);

	List<Board> boardList(int startRow, int endRow);

	// 후기 상세
	List<Board> boardDetailList(int bno);

	// 후기 지우기
	int deleteBoard(int bno);

	Board boardDetailContent(int bno);

	int deleteBoardRe(int bno);

}
