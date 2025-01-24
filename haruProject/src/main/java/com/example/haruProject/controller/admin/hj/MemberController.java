package com.example.haruProject.controller.admin.hj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Member;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.hj.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MemberController {
	private final MemberService ms;
	private final PasswordEncoder passwordEncoder;
	
	@GetMapping("/admin/members")
	public String memberView(	Model model,
								@RequestParam(value = "pageNum", required = false) String pageNum,
								@RequestParam(value = "blockSize", required = false, defaultValue = "10") String blockSize,
								@RequestParam(value = "type4", required = false, defaultValue = "0") int type4,
								@RequestParam(value = "type5", required = false, defaultValue = "0") int type5,
								@RequestParam(value = "search1", required = false) String search1
							) {
		System.out.println("MemberController memberView ...");
		List<Member> mList = new ArrayList();

		// 검색필터
		SearchItem si = new SearchItem(type4,type5,search1);
		System.out.println("MemberController memberView si->"+si);
		
		// 회원 전체수
		int totalCnt = ms.getTotalCnt(si);
		System.out.println("MemberController memberView totalCnt->"+totalCnt);
		// 페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		System.out.println("MemberController memberView pagination->"+pagination);
		// 회원 List
		mList = ms.getMemberList(pagination.getStartRow(), pagination.getEndRow(), si);
		System.out.println("MemberController memberView mList->"+mList);
		
		// 상태검색 옵션
		List<Common> mstatus = ms.mstatusList();
		
		model.addAttribute("pagination",pagination);
		model.addAttribute("members", mList);
		model.addAttribute("mstatus",mstatus);
		model.addAttribute("search",si);
		
	
		
		return "admin/members";
	}
	
	@GetMapping(value = "/admin/detailMember")
	public String getMemberDetail(
									@RequestParam("memno") int memno,
									Model model
								 ) {
		System.out.println("MemberDetail getMemberDetail ...");
		Member member = ms.getMemberDetail(memno);
		List<Pet> myPets = ms.getPetList(memno);
		List<Common> mstatus = ms.mstatusList();
		System.out.println("MemberController getMemberDetail member->"+member);
		model.addAttribute("member",member);
		model.addAttribute("myPets",myPets);
		model.addAttribute("mstatus",mstatus);
		
		return "admin/detailMember";
	}
	
	@GetMapping(value = "/admin/addMember")
	public String addMember() {
		
		return "admin/addMember";
	}
	
	@PostMapping(value = "/admin/addMemberAction")
	public String addMemberAction(Member member) {
		System.out.println("MemberController addMemberAction ...");
		System.out.println("========= "+member);
		
		String passwd = member.getMpasswd();
		
		String encodedPassword = passwordEncoder.encode(passwd);
		System.out.println("암호화: "+encodedPassword);
		
		member.setMpasswd(encodedPassword); //암호화된 패스워드 저장
		
		int result = ms.addMember(member);
		
		return "redirect:members";
	}
	
	@PostMapping(value = "/admin/updateMember")
	public String updateMember(Member member, Model model) {
		System.out.println("MemberController updateMember ...");
		System.out.println("MemberController updateMember member->"+member);
		int result = ms.updateMember(member);
		System.out.println("MemberController updateMember result->"+result);
		
		return "redirect:/admin/members";
		
	}
	
	@ResponseBody
	@PostMapping(value = "/api/dbCheckId")
	public int dbCheckId(@RequestBody Member member) {
		int result = 0;
		
		String email = member.getMemail();
		
		System.out.println("MemberController dbCheckId ...");
		System.out.println("MemberController dbCheckId  mid->"+ email);
		result = ms.dbCheckId(member);
		System.out.println("MemberController dbCheckId  result->"+ result);
		
		return result;
	}
	

}
