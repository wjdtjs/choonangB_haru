package com.example.haruProject.service.hr;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hr.UserMemberDao;
import com.example.haruProject.dto.Member;

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

	
}
