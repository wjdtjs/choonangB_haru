package com.example.haruProject.dao.hr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Member;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class UserMemberDaoImp implements UserMemberDao {
	private final SqlSession session;

	// 내 정보 수정 > 정보 불러오기
	@Override
	public Member getMyinfo(int memno) {
		System.out.println("UserMemberDaoImp getMyinfo() start ,,,");
		System.out.println("UserMemberDaoImp getMyinfo() memno ->"+memno);
		
		Member member = new Member();
		
		try {
			member = session.selectOne("HR_getMyinfo", memno);
		} catch (Exception e) {
			log.error("getMyinfo() error ->", e);
		}
		
		return member;
	}

	// 회원 탈퇴 > 상태 수정
	@Override
	public int deleteMember(int memno) {
		System.out.println("UserMemberDaoImp deleteMember() start ,,,");
		System.out.println("UserMemberDaoImp deleteMember() memno ->"+memno);
		
		int result = 0;
		
		try {
			result = session.update("HR_deleteMember", memno);
		} catch (Exception e) {
			log.error("deleteMember() error ->", e);
		}
		
		return result;
	}

	// 회원 정보 수정
	@Override
	public int updateMember(Member member) {
		System.out.println("UserMemberDaoImp updateMember() start ,,,");
		System.out.println("UserMemberDaoImp updateMember() member ->"+member);
		
		int result = 0;
		
		try {
			result = session.update("HR_updateMember", member);
		} catch (Exception e) {
			log.error("updateMember() error ->", e);
		}
		
		return result;
	}

	// 비밀번호 가져오기
	@Override
	public Member getRealPasswd(int memno) {
		System.out.println("UserMemberDaoImp getRealPasswd() start ,,,");
		System.out.println("UserMemberDaoImp getRealPasswd() memno ->"+memno);
		
		Member member = new Member();
		
		try {
			member = session.selectOne("HR_SelectPassword", memno);
		} catch (Exception e) {
			log.error("getRealPasswd() error ->", e);
		}
		return member;
	}

	// 내가 쓴 글 분류 조회
	@Override
	public List<Map<String, Object>> getMcdList() {
		List<Map<String, Object>> mList = new ArrayList<>();
		try {
			mList = session.selectList("HR_SelectBoardMcd");
		} catch (Exception e) {
			log.error("getMcdList() query error -> ", e);
		}
		
		System.out.println("커뮤니티 후기 분류 "+mList);
		
		return mList;
	}

	// 후기 수 조회
	@Override
	public int getReviewCnt(SearchItem si) {
		int totalCnt = 0;
		try {
			totalCnt = session.selectOne("HR_SelectReviewCnt", si);
		} catch (Exception e) {
			log.error("getReviewCnt() query error -> ", e);
		}
		
		return totalCnt;
	}

	// 필터 적용 후기 리스트 조회
	@Override
	public List<Board> getReviewList(int startRow, int endRow, SearchItem si) {
		List<Board> bList = new ArrayList<>();
		
		Map<String, Object> rMap = new HashMap<>();
		rMap.put("startRow", startRow);
		rMap.put("endRow", endRow);
		rMap.put("si", si);
		System.out.println("dao startRow: "+startRow);
		System.out.println("dao endRow: "+endRow);
		System.out.println("dao si: "+si);
		
		try {
			bList = session.selectList("HR_SelectReviewList", rMap);
			System.out.println("UserMemberDaoImp getReviewList() bList ->"+bList);
		} catch (Exception e) {
			log.error("getReviewList() query error -> ", e);
		}
		return bList;
	}

	// 댓글에 대한 원글 제목 불러오기
	@Override
	public List<Board> getTitleList() {
		List<Board> bList = new ArrayList<>();
		
		try {
			bList = session.selectList("HR_SelectTitleList");
			System.out.println("UserMemberDaoImp getReviewList() bList ->"+bList);
		} catch (Exception e) {
			log.error("getReviewList() query error -> ", e);
		}
		return bList;
	}

	// 댓글 삭제 > 상태 변경
	@Override
	public int deleteRe(int bno) {
		System.out.println("UserMemberDaoImp getRealPasswd() start ,,,");
		System.out.println("UserMemberDaoImp getRealPasswd() bno ->"+bno);
		
		int result = 0;
		
		try {
			result = session.update("HR_deleteRe", bno);
		} catch (Exception e) {
			log.error("deleteRe() query error -> ", e);
		}
		
		return result;
	}
	
	

}
