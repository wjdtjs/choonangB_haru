package com.example.haruProject.dao.js;

import java.util.List;

import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.Member;

public interface MemberDao {

	boolean chkIdDuplicate(Member member);
	void updateAuthCode(Member member);
	Member getAuthCode(String email);
	void signUpMember(Member mem);
	String findEmail(Member member);
	void updatePassword(String encodedPassword, Member member);
	Member getRealPasswd(Member member);
	Admin chkAdminExist(Admin admin);
	int chkKakaoUser(Member member);
	List<Member> chkMemberTime();
	void cancelMember(Member member);

}
