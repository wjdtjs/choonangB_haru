package com.example.haruProject.dao.hr;

import java.util.List;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.SearchItem;

public interface BoardDao {

	int getTotalCnt(SearchItem si);

	List<Board> boardList(int startRow, int endRow, int type4, String search1);

	List<Board> boardDetailList(int bno);

	int deleteBoard(int bno);

	Board boardDetailContent(int bno);

	int deleteBoardRe(int bno);

}
