package com.example.haruProject.controller.admin.js;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OAuthController {
	
	/**
	 * 카카오 로그인 redirect url
	 */
	@GetMapping("api/oauth/kakao")
	public void kakao_login() {
		
	}
}
