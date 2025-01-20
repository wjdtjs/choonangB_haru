package com.example.haruProject.dao.hj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Member;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberDaoImpl implements MemberDao {
	
	private final SqlSession session;
	
	@Override
	public int getTotalCnt() {
		System.out.println("MemberDao getTotalCnt...");
		
		int result = 0;
		try {
			result = session.selectOne("HJGetTotalMember");
		} catch (Exception e) {
			System.out.println("MemberDao getTotalCnt error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public List<Member> getMemberList(int startRow, int endRow, SearchItem si) {
		System.out.println("MemberDao getMemberList...");
		List<Member> members = new ArrayList<>();
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("startRow", startRow);
		paramMap.put("endRow", endRow);
		paramMap.put("search", si);
		try {
			members = session.selectList("HJSelectMembers",paramMap);
			System.out.println("MemberDao getMemberList members->"+members);
		} catch (Exception e) {
			System.out.println("MemberDao getMemberList error->"+e.getMessage());
			
		}
		return members;
	}

	@Override
	public Member getMemberDetail(int memno) {
		System.out.println("MemberDao getMemberDetail ...");
		Member member = null;
		 try {
			member = session.selectOne("HJMemberDetail",memno);
		} catch (Exception e) {
			System.out.println("MemberDao getMemberDetail error->"+e.getMessage());
		}
		return member;
	}

	@Override
	public List<Pet> getPetList(int memno) {
		System.out.println("MemberDao getPet");
		List<Pet> myPets = null;
		try {
			myPets = session.selectList("HJSelectMyPets",memno);
		} catch (Exception e) {
			System.out.println("MemberDao getPetList error->"+e.getMessage());
		}
		return myPets;
	}

	@Override
	public int addMember(Member member) {
		System.out.println("MemberDao addMember ...");
		int result = 0;
		try {
			result = session.insert("HJInsertMember", member);
		} catch (Exception e) {
			System.out.println("MemberDao addMember error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public List<Common> mstatusList() {
		System.out.println("MemberDao mstatusList ...");
		List<Common> mstatus = new ArrayList<>();
		try {
			mstatus = session.selectList("HJMstatusList");
			System.out.println("mstatus->"+mstatus);
		} catch (Exception e) {
			System.out.println("MemberDao mstatusList error->"+e.getMessage());
		}
		return mstatus;
	}
	
}
