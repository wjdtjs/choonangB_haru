package com.example.haruProject.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserViewController {

	/**
	 * 사용자페이지 메인 뷰
	 * @return
	 */
	@GetMapping("/user/main")
	public String mainView() {
		
		return "user/main";
	}
	
}
