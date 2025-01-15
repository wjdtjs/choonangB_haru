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
import com.example.haruProject.dto.SearchItem;
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
								@RequestParam(value = "search1", required = false) String search1,
								@RequestParam(value = "search2", required = false) String search2,
								@RequestParam(value = "type1", required = false) String type1
								)
	{
		System.out.println("AppointmentController appointmentList() start ,,,");
		List<Appointment> aList = new ArrayList<>();
		Map<String, Object> aListMap = new HashMap<>();
		
		// 검색 필터
		SearchItem si = new SearchItem(search1, search2, type1);
		
		// 예약 전체 수
		int totalCnt = as.getTotalCnt(si);
		
		// 페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		// 페이지네이션 적용된 예약 목록
		aList = as.appointmentList(pagination.getStartRow(), pagination.getEndRow(), si);
		System.out.println(aList);
		
		aListMap.put("pagination", pagination);
		aListMap.put("list", aList);
		
		System.out.println(aList);
		
		return aListMap;
		
	}
	
	
	// 진료 관리 -> 예약상태가 '예약 확정 후 진료 완료' 인 경우의 데이터 불러오기 
	@GetMapping("api/consultation-list")
	public Map<String, Object> consultationList(
								@RequestParam(value = "pageNum", required = true) String pageNum,
								@RequestParam(value = "blockSize", required = false, defaultValue="10") String blockSize
								)
	{
		System.out.println("AppointmentController consultationList() start ,,,");
		List<Appointment> cList = new ArrayList<>();
		Map<String , Object> cListMap = new HashMap<>();
		
		// getTotalCnt 은 이름이 겹쳐서 차트에 들어갈 리스트는 getTotalCntChart 사용
		int totalCnt = as.getTotalCntChart();
		
		// 페이지 네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		// 페이지네이션 적용 진료 목록
		cList = as.consultationListChart(pagination.getStartRow(), pagination.getEndRow());
		
		cListMap.put("pagination", pagination);
		cListMap.put("list", cList);
		
		return cListMap;		
		
	}
	
	
}
