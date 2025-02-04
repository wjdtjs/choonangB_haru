package com.example.haruProject.service.hr;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hr.UserMemberDao;
import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Member;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserMemberServiceImp implements UserMemberService {
	private final UserMemberDao md;
	
	// 회원 정보 수정 > 회원 정보 불러오기
	@Override
	public Member getMyinfo(int memno) {
		System.out.println("UserMemberServiceImp getMyinfo() start ,,,");
		System.out.println("UserMemberServiceImp getMyinfo() memno ->"+memno);
		
		Member member = md.getMyinfo(memno);
		
		return member;
	}

	// 회원 탈퇴 > 상태 변경
	@Override
	public int deleteMember(int memno) {
		System.out.println("UserMemberServiceImp deleteMember() start ,,,");
		System.out.println("UserMemberServiceImp deleteMember() memno ->"+memno);
		
		int result = md.deleteMember(memno);
		
		return result;
	}

	// 회원 정보 수정
	@Override
	public int updateMember(Member member) {
		System.out.println("UserMemberServiceImp updateMember() start ,,,");
		System.out.println("UserMemberServiceImp updateMember() member ->"+member);
		
		int result = md.updateMember(member);

		return result;
	}

	// 비밀번호 가져오기
	@Override
	public Member getRealPasswd(int memno) {
		System.out.println("UserMemberServiceImp getRealPasswd() start ,,,");
		System.out.println("UserMemberServiceImp getRealPasswd() memno ->"+memno);
		
		Member member = md.getRealPasswd(memno);
		
		return member;
	}

	// 커뮤니티 분류 조회 (수술, 진료, 상품
	@Override
	public List<Map<String, Object>> getMcdList() {
		System.out.println("UserMemberServiceImp getMcdList() start ,,,");

		List<Map<String, Object>> mList = new ArrayList<>();
		mList = md.getMcdList();
		return mList;
	}

	// 후기 수
	@Override
	public int getReviewCnt(SearchItem si) {
		int totalCnt = md.getReviewCnt(si);
		return totalCnt;
	}

	// 후기 리스트 필터 적용
	@Override
	public List<Board> getReviewList(int startRow, int endRow, SearchItem si) {
		List<Board> bList = new ArrayList<>();
		
		System.out.println("service startRow: "+startRow);
		System.out.println("service endRow: "+endRow);
		System.out.println("service si: "+si);
		
		bList = md.getReviewList(startRow, endRow, si);
		return bList;
	}

	// 댓글에 대한 원글 제목 불러오기
	@Override
	public List<Board> getTitleList() {
		List<Board> bList = new ArrayList<>();
		
		bList = md.getTitleList();
		return bList;
	}

	// 댓글 삭제 > 상태 변경
	@Override
	public int deleteRe(int bno) {
		System.out.println("UserMemberServiceImp deleteRe() start ,,,");
		System.out.println("UserMemberServiceImp deleteRe() bno-> "+bno);
		
		int result = md.deleteRe(bno);
		
		return result;
	}

	
}
