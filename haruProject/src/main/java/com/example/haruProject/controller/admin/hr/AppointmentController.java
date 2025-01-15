package com.example.haruProject.controller.admin.hr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.service.hr.AppointmentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class AppointmentController {
	private final AppointmentService as;
	
	
	// 예약 조회
	@GetMapping("api/appointment-list")
	public Map<String, Object> appointmentList(
								@RequestParam(value = "pageNum", required = true) String pageNum,
								@RequestParam(value = "blockSize", required = false, defaultValue="10") String blockSize,
								@RequestParam(value = "search1", required = false) String search1
								)
	{
		System.out.println("AppointmentController appointmentList() start ,,,");
		List<Appointment> aList = new ArrayList<>();
		Map<String, Object> aListMap = new HashMap<>();
		
		// 예약 전체 수
		int totalCnt = as.getTotalCnt();
		
		// 페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		// 페이지네이션 적용된 예약 목록
		aList = as.appointmentList(pagination.getStartRow(), pagination.getEndRow());
		System.out.println(aList);
		
		aListMap.put("pagination", pagination);
		aListMap.put("list", aList);
		
		System.out.println(aList);
		
		return aListMap;
		
	}
}
