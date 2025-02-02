package com.example.haruProject.service.hr;

import com.example.haruProject.dto.Member;

public interface UserMemberService {

	Member getMyinfo(int memno);

	int deleteMember(int memno);

	int updateMember(Member member);

}
