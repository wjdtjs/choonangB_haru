package com.example.haruProject.dao.hr;

import java.util.List;

import com.example.haruProject.dto.Board;

public interface BoardDao {

	int getTotalCnt();

	List<Board> boardList(int startRow, int endRow);

	List<Board> boardDetailList(int bno);

}
