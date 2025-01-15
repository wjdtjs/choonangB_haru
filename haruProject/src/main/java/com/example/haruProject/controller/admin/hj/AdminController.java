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

import ch.qos.logback.core.model.Model;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminController {
	
	private final AdminService as;
	
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

}
