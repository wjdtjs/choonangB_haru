package com.example.haruProject.service.js;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.js.MemberDao;
import com.example.haruProject.dto.Admin;
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
	public boolean chkIdDuplicate(Member member) {
		boolean result = md.chkIdDuplicate(member);
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

	/**
	 * 이메일 찾기
	 */
	@Override
	public String findEmail(Member member) {
		String email = md.findEmail(member);
		return email;
	}

	/**
	 * 재설정된 비밀번호 저장
	 */
	@Override
	public void updatePassword(String encodedPassword, Member member) {
		md.updatePassword(encodedPassword, member);
	}

	/**
	 * 비밀번호 가져오기
	 */
	@Override
	public Member getRealPasswd(Member member) {
		Member m = md.getRealPasswd(member);
		return m;
	}

	
	/**
	 * 관리자 정보 확인
	 */
	@Override
	public Admin chkAdminExist(Admin admin) {
		Admin ad_info = new Admin();
		ad_info = md.chkAdminExist(admin);
		
		return ad_info;
	}

	/**
	 * 카카오 로그인 -> insert
	 */
	@Override
	public int chkKakaoUser(Member member) {
		int memno = md.chkKakaoUser(member);
		return memno;
	}

	/**
	 * 이메일 인증 유효시간 지난 member 불러오기
	 */
	@Override
	public List<Member> chkMemberTime() {
		List<Member> mList = md.chkMemberTime();
		
		return mList;
	}

	/**
	 * 이메일 인증 유효시간 지난 member 삭제하기
	 */
	@Override
	public void cancelMember(Member member) {
		md.cancelMember(member);		
	}


}
