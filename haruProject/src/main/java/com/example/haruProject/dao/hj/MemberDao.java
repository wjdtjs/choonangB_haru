package com.example.haruProject.dao.hj;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Member;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.SearchItem;

public interface MemberDao {

	int 			getTotalCnt(SearchItem si);
	List<Member> 	getMemberList(int startRow, int endRow, SearchItem si);
	Member			getMemberDetail(int memno);
	List<Pet>		getPetList(int memno);
	int				addMember(Member member);
	List<Common>	mstatusList();
	int				updateMember(Member member);
	int				dbCheckId(String mid);

}
