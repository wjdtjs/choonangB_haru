package com.example.haruProject.controller.user.js;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.haruProject.dto.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class OAuthController {
	
	/**
	 * 카카오 로그인 redirect url
	 */
	@ResponseBody
	@GetMapping("api/oauth/kakao")
	public void kakao_login() {
		
	}
	

	/**
	 * 회원가입
	 * @return
	 */
	@PostMapping("/user/signUp")
	public String userSignUp(Member mem, Model model) {
		log.info("userSignUp() start..");
		
		System.out.println("회원가입 : "+mem);
		
		return "redirect:login";
	}
	
}
