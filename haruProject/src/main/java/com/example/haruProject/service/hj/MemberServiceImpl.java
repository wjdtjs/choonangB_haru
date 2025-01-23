package com.example.haruProject.service.hj;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.MemberDao;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Member;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private final MemberDao md;
	
	@Override
	public int getTotalCnt() {
		System.out.println("MemberService getTotalCnt ...");
		int totalCnt = md.getTotalCnt();
		return totalCnt;
	}

	@Override
	public List<Member> getMemberList(int startRow, int endRow, SearchItem si) {
		System.out.println("MemberService getMemberist...");
		List<Member> memList = md.getMemberList(startRow,endRow,si);
		return memList;
	}

	@Override
	public Member getMemberDetail(int memno) {
		System.out.println("MemberService getMemberDetail...");
		Member member = md.getMemberDetail(memno);
		return member;
	}

	@Override
	public List<Pet> getPetList(int memno) {
		System.out.println("MemberService getPetList...");
		List<Pet> myPets = md.getPetList(memno);
		return myPets;
	}

	@Override
	public int addMember(Member member) {
		System.out.println("MemberService addMember...");
		int result = md.addMember(member);
		return result;
	}

	@Override
	public List<Common> mstatusList() {
		System.out.println("MemberService mstatusList...");
		List<Common> mstatus = md.mstatusList();
		return mstatus;
	}

	@Override
	public List<Common> mstatusList1() {
		System.out.println("MemberService mstatusList1...");
		List<Common> mstatus = md.mstatusList1();
		return mstatus;
	}

	@Override
	public int updateMember(Member member) {
		int result = md.updateMember(member);
		return result;
	}

	@Override
	public int dbCheckId(String email) {
		System.out.println("MemberService dbCheckId...");
		int result = md.dbCheckId(email);
		return result;
	}

}
