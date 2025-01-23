package com.example.haruProject.dao.js;

import com.example.haruProject.dto.Member;

public interface MemberDao {

	boolean chkIdDuplicate(String id);
	void updateAuthCode(Member member);
	Member getAuthCode(String email);
	void signUpMember(Member mem);

}
