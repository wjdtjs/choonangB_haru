package com.example.haruProject.service.hr;

import java.util.List;

import com.example.haruProject.dto.Board;

public interface BoardService {

	int getTotalCnt();

	List<Board> boardList(int startRow, int endRow);

	// 후기 상세
	List<Board> boardDetailList(int bno);

}
