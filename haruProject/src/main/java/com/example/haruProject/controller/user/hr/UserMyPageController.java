package com.example.haruProject.controller.user.hr;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Member;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.service.hr.UserMemberService;
import com.example.haruProject.service.hr.UserPetService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class UserMyPageController {

	private final UserMemberService ms;
	private final UserPetService ps;
	
	/**
	 * 사용자페이지 - 마이페이지 뷰 
	 * @return
	 */
	@GetMapping("/user/myPage")
	public String UserMyPageView(@RequestParam (value = "memno", required = true, defaultValue = "1") int memno,
								 Model model) {
		log.info("myPage view start ,,,");
		
		System.out.println("UserPetController getPet() memno ->"+memno);

		List<Pet> pList = ps.getPetList(memno);
		
		model.addAttribute("pList", pList);
		
		return "user/myPage";
	}
	
	/**
	 * 내 정보 수정 뷰
	 * @return
	 */
	@GetMapping("/user/editMyinfo")
	public String editMyinfoView(@RequestParam(value = "memno", required = true, defaultValue = "1") int memno, Model model) {
		System.out.println("UserMyPageController editMyinfoView() start ,,,");
		System.out.println("UserMyPageController editMyinfoView() memno-> "+memno);
		
		Member member = ms.getMyinfo(memno);
		
		model.addAttribute("member", member);
		
		return "user/editMyinfo";
	}
	
	/**
	 * 회원 탈퇴
	 * @return
	 */
	@RequestMapping("/user/deleteMember")
	public String deleteMember(@RequestParam(value = "memno", required = true, defaultValue = "1") int memno ) {
		System.out.println("UserMyPageController deleteMember() start ,,,");
		System.out.println("UserMyPageController deleteMember() memno ->"+memno);
		
		int result = ms.deleteMember(memno);
		
		return "redirect:/all/user/login";
	}
	
	/**
	 * 회원 정보 수정
	 * @return
	 */
	@RequestMapping("/user/updateMember")
	public String updateMember(@ModelAttribute("member") Member member) {
		System.out.println("UserMyPageController updateMember() start ,,,");
		System.out.println("UserMyPageController updateMember() member ->"+member);
		
		int result = 0;
		
		result = ms.updateMember(member);
		
		if (result > 0) {
	        return "redirect:/user/myPage?memno="+member.getMemno(); // 수정 후 마이페이지로 이동
	    } else {
	        return "redirect:/user/editMyinfo?memno="+member.getMemno(); // 다시 수정 페이지로 이동
	    }
		
		
	}
	
}
