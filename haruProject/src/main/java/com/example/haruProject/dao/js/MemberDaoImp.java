package com.example.haruProject.dao.js;

import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

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
	public boolean chkIdDuplicate(Member member) {
		boolean result = false;
		int dul_cnt = 0;
		
		try {
			dul_cnt = session.selectOne("JS_SelectIdDuplCnt", member);
			System.out.println("중복 개수 "+dul_cnt);
		} catch (Exception e) {
			log.error("chkIdDuplicate() query error -> {}", e);
		}
		
		
		if(dul_cnt > 0) { //중복있음
			result = false;
		} else { 		  //중복없음
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

	/**
	 * 이메일 찾기
	 */
	@Override
	public String findEmail(Member member) {
		String email = "";
		
		//혹시 테스트 하다가 중복데이터가 실수로 들어갔을 때를 대비..
		List<String> elist = new ArrayList<>(); 
		try {
			elist = session.selectList("JS_SelectEmail", member);
		} catch (Exception e) {
			log.error("findEmail() query error -> ", e);
		}
		System.out.println("MemberDao() findEmail() email -> "+ elist);
		
		if(elist.size() > 0) {
			email = elist.get(0);			
		}
		
		
//		System.out.println("find email : "+email);
		
		return email;
	}

	/**
	 * 재설정된 비밀번호 저장
	 */
	@Override
	public void updatePassword(String encodedPassword, Member member) {
		Map<String, Object> pMap = new HashMap<>();
		pMap.put("encyrpt_pw", encodedPassword);
		pMap.put("member", member);
		
		try {
			session.update("JS_UpdatePassword", pMap);
		} catch (Exception e) {
			log.error("updatePassword() query error -> ", e);
		}
		
	}

	/**
	 * 비밀번호 가져오기
	 */
	@Override
	public Member getRealPasswd(Member member) {
		Member m = new Member();
		
		//혹시 테스트 하다가 중복데이터가 실수로 들어갔을 때를 대비..
		List<Member> elist = new ArrayList<>(); 
		try {
			elist = session.selectList("JS_SelectPassword", member);
		} catch (Exception e) {
			log.error("getRealPasswd() query error -> ", e);
		}
		
		
		if(elist.size() > 0) {
			m = elist.get(0);			
		}
		
		return m;
	}

}
