package com.example.haruProject.dao.hr;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Member;

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
	
	

}
