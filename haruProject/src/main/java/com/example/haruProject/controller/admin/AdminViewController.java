package com.example.haruProject.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Order;
import com.example.haruProject.service.hj.AdminService;
import com.example.haruProject.service.hj.OrderService;
import com.example.haruProject.service.hr.AppointmentService;
import com.example.haruProject.service.js.ShopService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminViewController {
	
	private final ShopService ss;
	private final AdminService ads;
	
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
	
	private final OrderService os;
	private final AppointmentService as;
	
	@GetMapping("/admin/index")
	public String indexView(Model model) {
		System.out.println("admin mainView start ,,,");
		
		// 픽업 대기 리스트
		List<Order> sList = os.getMainOList();
		
		// 대기 중 예약 리스트
		List<Appointment> aList = as.getMainAList();
		aList.forEach(appointment -> {
	        String startTime = String.valueOf(appointment.getStart_time());
	        if (startTime.length() == 4) { // 1530 -> 15:30
	            appointment.setStart_time(startTime.substring(0, 2) + ":" + startTime.substring(2));
	        }
	    });
		
		// 오늘의 예약
		int today_res = as.getTodayRes();
		// 대기 중 예약
		int wait_res = as.getWaitRes();
		// 픽업 대기
		int wait_pur = os.getWaitPur();
		
		model.addAttribute("sales", sList);
		model.addAttribute("aList", aList);
		model.addAttribute("today_res", today_res);
		model.addAttribute("wait_res", wait_res);
		model.addAttribute("wait_pur", wait_pur);
		
		return "admin/main";
	}
	
	/**
	 * 관리자페이지 관리자 뷰
	 * @return
	 */
	@GetMapping("/admin/doctor")
	public String docView(Model model) {
		List<Map<String, Object>> bcdmcdList = ads.acommonList();
		List<Map<String, Object>> statusList = bcdmcdList.stream()
			    .filter(map -> "200".equals(String.valueOf(map.get("BCD"))))
			    .collect(Collectors.toList());

		model.addAttribute("statusList",statusList);
		
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
	

	
	
}
