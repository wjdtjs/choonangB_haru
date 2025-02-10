package com.example.haruProject.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.haruProject.service.js.ShopService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminViewController {
	
	private final ShopService ss;
	
	//TODO: 비밀번호 관리 뷰 만들기
	//TODO: 탈퇴 뷰 만들기

	/**
	 * 관리자페이지 로그인 뷰
	 * @return
	 */
	@GetMapping("/all/admin/login")
	public String loginView() {
		
		return "admin/login";
	}
	
	/**
	 * 관리자페이지 메인 뷰
	 * @return
	 */
	@GetMapping("/admin/index")
	public String indexView() {
		
		
		
		return "admin/main";
	}
	
	/**
	 * 관리자페이지 관리자 뷰
	 * @return
	 */
	@GetMapping("/admin/doctor")
	public String docView() {
		return "admin/doctor";
	}
	
	/**
	 * 관리자페이지 근무관리 뷰
	 * @return
	 */
	@GetMapping("/admin/schedule")
	public String schView() {
		return "admin/schedule";
	}
	
	/**
	 * 관리자페이지 진료항목 관리 뷰
	 * @return
	 */
	@GetMapping("/admin/medical")
	public String medicalView() {
		return "admin/medical";
	}

	/**
	 * 관리자페이지 재고관리 뷰
	 * @return
	 */
	@GetMapping("/admin/stock")
	public String stockView(Model model) {
		
		//상태 정보
		List<Map<String, Object>> statusList = new ArrayList<>();
		statusList = ss.getStatusList();
//		System.out.println(statusList);
		
		model.addAttribute("statusList", statusList);
		
		return "admin/stock";
	}
	
	

	/**
	 * 관리자페이지 동물관리 뷰
	 * @return
	 */
	@GetMapping("/admin/animals")
	public String animalView() {
		return "admin/animals";
	}
	

	
	
}
