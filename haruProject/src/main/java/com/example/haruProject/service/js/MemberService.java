package com.example.haruProject.service.js;

import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.Member;

public interface MemberService {

	boolean chkIdDuplicate(Member member);
	void updateAuthCode(Member member);
	Member getAuthCode(String email);
	void signUpMember(Member mem);
	String findEmail(Member member);
	void updatePassword(String encodedPassword, Member member);
	Member getRealPasswd(Member member);
	Admin chkAdminExist(Admin admin);
	int chkKakaoUser(Member member);

}
