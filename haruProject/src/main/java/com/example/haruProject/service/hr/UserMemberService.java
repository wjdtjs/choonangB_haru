package com.example.haruProject.service.hr;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Member;
import com.example.haruProject.dto.SearchItem;

public interface UserMemberService {

	Member getMyinfo(int memno);

	int deleteMember(int memno);

	int updateMember(Member member);

	Member getRealPasswd(int memno);

	// 내가 쓴 글
	List<Map<String, Object>> getMcdList();

	int getReviewCnt(SearchItem si);

	List<Board> getReviewList(int startRow, int endRow, SearchItem si);

	List<Board> getTitleList();

	// 댓글 삭제
	int deleteRe(int bno);

	String getUserID(int memno);

}
