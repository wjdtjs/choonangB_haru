package com.example.haruProject.dao.hr;

import com.example.haruProject.dto.Member;

public interface UserMemberDao {

	Member getMyinfo(int memno);

	int deleteMember(int memno);

	int updateMember(Member member);

}
