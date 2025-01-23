package com.example.haruProject.service.js;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.js.MemberDao;
import com.example.haruProject.dto.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberServiceImp implements MemberService {
	
	private final MemberDao md;

	/**
	 * 아이디 중복 체크
	 * @return 
	 */
	@Override
	public boolean chkIdDuplicate(String email) {
		boolean result = md.chkIdDuplicate(email);
		return result;
	}

	/**
	 * 인증코드, 전송시간 저장
	 */
	@Override
	public void updateAuthCode(Member member) {
		md.updateAuthCode(member);
	}

	/**
	 * 저장된 인증코드, 전송시간 가져오기
	 */
	@Override
	public Member getAuthCode(String email) {
		Member m = new Member();
		m = md.getAuthCode(email);
		
		return m;
	}

	/**
	 * 회원가입
	 */
	@Override
	public void signUpMember(Member mem) {
		md.signUpMember(mem);
		
	}

}
