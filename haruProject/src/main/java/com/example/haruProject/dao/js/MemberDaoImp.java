package com.example.haruProject.dao.js;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class MemberDaoImp implements MemberDao {
	
	private final SqlSession session;

	/**
	 * 이메일 중복 체크
	 */
	@Override
	public boolean chkIdDuplicate(String email) {
		boolean result = false;
		int dul_cnt = 0;
		
		try {
			dul_cnt = session.selectOne("JS_SelectIdDuplCnt", email);
			System.out.println("중복 개수 "+dul_cnt);
		} catch (Exception e) {
			log.error("chkIdDuplicate() query error -> {}", e);
		}
		
		
		if(dul_cnt > 0) {
			result = false;
		} else {
			result = true;
		}
		
		return result;
	}

	/**
	 * 인증코드, 전송시간 저장
	 */
	@Override
	public void updateAuthCode(Member member) {
		int result = 0;
		try {
			result = session.update("JS_EmailAuthMergeInto", member);
		} catch (Exception e) {
			log.error("updateAuthCode() query error -> {}", e);
		}
		
		System.out.println("인증번호 저장 결과: "+result);
	}

	/**
	 * 저장된 인증코드, 전송시간 가져오기
	 */
	@Override
	public Member getAuthCode(String email) {
		Member m = new Member();
		try {
			m = session.selectOne("JS_SelectAuthCode", email);
		} catch (Exception e) {
			log.error("updateAuthCode() query error -> ", e);
		}
		return m;
	}

	/**
	 * 회원가입
	 */
	@Override
	public void signUpMember(Member mem) {
		int result = 0;
		try {
			result = session.update("JS_SignUpMember", mem);
		} catch (Exception e) {
			log.error("signUpMember() query error -> ", e);
		}
		
		System.out.println("회원가입 쿼리 결과: "+result);
	}

}
