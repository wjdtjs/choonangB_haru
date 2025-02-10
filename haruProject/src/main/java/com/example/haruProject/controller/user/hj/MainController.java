package com.example.haruProject.controller.user.hj;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.service.hj.UserMainService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	private final UserMainService us;

	/**
	 * 사용자페이지 메인 뷰
	 * @return
	 */
	@GetMapping("/user/index")
	public String mainView(Model model, HttpServletRequest request) {
		System.out.println("MainController main view");
		
		int memno = SessionUtil.getNo(request);
		
		/* 상단고정 공지사항 */
		List<Notice> notices = us.getNoticeList();
		
		/* 내 동물정보 */
		List<Pet> pets = us.getPetList(memno);
		System.out.println("pets->"+pets);
		
		/* 다가오는 예약 */
		Appointment commingRes = us.getCommingRes(memno);
		System.out.println("commingRes->"+commingRes);
		
		model.addAttribute("notices",notices);
		model.addAttribute("pets",pets);
		model.addAttribute("res",commingRes);
		
		return "user/main";
	}
}
