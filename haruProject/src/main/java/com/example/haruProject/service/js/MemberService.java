package com.example.haruProject.service.js;

import com.example.haruProject.dto.Member;

public interface MemberService {

	boolean chkIdDuplicate(String id);
	void updateAuthCode(Member member);
	Member getAuthCode(String email);
	void signUpMember(Member mem);

}
