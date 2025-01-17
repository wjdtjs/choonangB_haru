package com.example.haruProject.dao.hr;

import java.util.List;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.SearchItem;

public interface BoardDao {

	int getTotalCnt(SearchItem si);

	List<Board> boardList(int startRow, int endRow);

	List<Board> boardDetailList(int bno);

	int deleteBoard(int bno);

	Board boardDetailContent(int bno);

	int deleteBoardRe(int bno);

}
