package com.example.haruProject.controller.admin.hj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.hj.AdminService;

import org.springframework.ui.Model;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminController {
	
	private final AdminService as;
	
	// 관리자 리스트
	@ResponseBody
	@GetMapping(value = "/api/admin-list")
	public Map<String, Object> adminList(
											@RequestParam(value = "pageNum", required = true) String pageNum,
											@RequestParam(value = "blockSize", required = false, defaultValue = "10")String blockSize,
											@RequestParam(value = "search1", required = false)String search1
										){
		System.out.println("AdminController adminList");
		
		List<Admin> aList = new ArrayList<>();
		Map<String, Object> aListMap = new HashMap<>();
		
		// 검색필터
		SearchItem si = new SearchItem(search1);
		
		// 상품 전체 수 (필터 적용)
		int totalCnt = as.getTotalCnt(si);
		
		// 페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		//페이지네이션 적용된 상품 목록
		aList = as.adminList(pagination.getStartRow(), pagination.getEndRow(), si);
		System.out.println("aList->"+aList);
		
		
		aListMap.put("pagination", pagination);
		aListMap.put("list", aList);
		
		System.out.println("AdminController adminList aListMap->"+aListMap);
		
		return aListMap;
	}

	// 관리자 추가 : Role
	@ResponseBody
	@GetMapping(value = "/api/alevel-mcd")
	public Map<String,Object> adminLevelMcd (){
		System.out.println("AdminController adminLevelMcd Start,,,");
		List<Admin> alevelList = new ArrayList<>(); 
		Map<String, Object> alevelMap = new HashMap<>();
	  
		alevelList = as.adminLevelMcd();
		alevelMap.put("alevelList", alevelList);
		System.out.println(alevelMap);
		return alevelMap;
	  
	}
	 
	@ResponseBody
	@PostMapping(value = "/api/addAdmin")
	public ModelAndView addAdminAPI(Admin admin) {
		System.out.println("AdminController addAdmin Start,,,");
		
		// 관리자추가
		int addAdminResult = as.adminAdd(admin);
		System.out.println("AdminController addAdmin addAdmin ->"+ addAdminResult);
		
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("redirect:/admin/doctor"); // 리다이렉트할 URL 설정
	    return modelAndView;
	}
	
	// 관리자 정보
	@ResponseBody
	@GetMapping(value = "/api/getAdminDetails")
	public Admin getAdminDetail(@RequestParam(value = "ano", required = true) int ano) {
		System.out.println("AdminController getAdminDetails Start...");
		Admin adminDatail = as.getAdminDetail(ano);
		
		System.out.println("AdminController getAdminDetails adminDatail->"+adminDatail);
		return adminDatail;
	}
	
	// 관리자 정보 수정 : Role, 상태 가져옴
	@ResponseBody
	@GetMapping(value = "/api/admin-common")
	public Map<String, Object> adminBcdMcd() {
		System.out.println("AdminController adminBcdMcd Start,,,");

		List<Admin> commonList = new ArrayList<>();
		Map<String, Object> commonMap = new HashMap<>();
			
		commonList = as.adminBcdMcd();
		commonMap.put("adminCommon", commonList);
			
		return commonMap;
	}
	
	// 관리자 정보
	@GetMapping(value = "/admin/AdminDetail")
	public String getAdminDetail(@RequestParam("ano") String ano,Model model) {
		System.out.println("AdminController getAdminDetail... ");
		System.out.println("AdminController getAdminDetailano- >"+ano);
		
		Admin admin = as.getAdminDetail(Integer.parseInt(ano));
		model.addAttribute("admin",admin);
		
		return "/admin/adminDetail";
	}
	
	// 관리자 정보 수정
	@PostMapping(value = "/updateAdmin")
	public String updateAdmin (Admin admin) {
		System.out.println("AdminController updateAdmin...");
		System.out.println("AdminController updateAdmin admin->"+admin);
		int result = as.updateAdmin(admin);
		
		return "redirect:/admin/doctor";
		
	}
}
