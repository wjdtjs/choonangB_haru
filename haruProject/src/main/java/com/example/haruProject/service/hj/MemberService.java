package com.example.haruProject.service.hj;

import java.util.List;

import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Member;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.SearchItem;

public interface MemberService {

	int 			getTotalCnt();
	List<Member>	getMemberList(int startRow, int endRow, SearchItem si);
	Member			getMemberDetail(int memno);
	List<Pet> 		getPetList(int memno);
	int				addMember(Member member);
	List<Common>	mstatusList();

}
