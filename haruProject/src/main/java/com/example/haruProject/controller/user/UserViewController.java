package com.example.haruProject.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	@GetMapping("/all/user/login")
	public String loginView() {
		
		return "user/login";
	}
	
	/**
	 * 약관동의 페이지
	 * @return
	 */
	@GetMapping("/all/user/agreement")
	public String signUpAgreementView() {
		return "user/agreement";
	}
	
	/**
	 * 아이디 찾기 페이지
	 * @return
	 */
	@GetMapping("/all/user/find-id")
	public String findEmail() {
		return "user/findEmail";
	}
	
	/**
	 * 비밀번호 찾기 페이지
	 * @return
	 */
	@GetMapping("/all/user/find-passwd")
	public String findPassword() {
		return "user/findPasswd";
	}
	
	
	
}
