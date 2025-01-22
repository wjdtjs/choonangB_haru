package com.example.haruProject.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserViewController {

	/**
	 * 사용자페이지 메인 뷰
	 * @return
	 */
	@GetMapping("/user/index")
	public String mainView() {
		
		return "user/main";
	}
	
	/**
	 * 로그인 페이지
	 * @return
	 */
	@GetMapping("/user/login")
	public String loginView() {
		
		return "user/login";
	}
	
	/**
	 * 약관동의 페이지
	 * @return
	 */
	@GetMapping("/user/agreement")
	public String signUpAgreementView() {
		return "user/agreement";
	}
	
	/**
	 * 회원가입 페이지
	 * @return
	 */
	@GetMapping("/user/signup")
	public String signUpView() {
		
		return "user/signup";
	}
	
}
