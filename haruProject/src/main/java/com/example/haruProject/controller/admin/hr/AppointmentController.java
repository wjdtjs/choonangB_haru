package com.example.haruProject.controller.admin.hr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.hr.AppointmentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class AppointmentController {
	private final AppointmentService as;
	
	/**
	 * 관리자페이지 예약관리 뷰
	 * @return
	 */
	// 예약 내역 조회 (검색 포함)
	@GetMapping("/admin/reservation")
	public String appointmentList(
						@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pageNum,
						@RequestParam(value = "blockSize", required = false, defaultValue="10") String blockSize,
						@RequestParam(value = "search1", required = false, defaultValue = "") String search1,
						@RequestParam(value = "type4", required = false, defaultValue = "0") int type4,
						@RequestParam(value = "type5", required = false, defaultValue = "100") int type5,
						Model model
						) 
	{
		System.out.println("/admin/reservation start ,,,");
		System.out.println("AppointmentController appointmentList() start ,,,");
		
		List<Appointment> aList = new ArrayList<>();
		
		SearchItem si = new SearchItem(type4, type5, search1);
		
		int totalCnt = as.getTotalCnt(si);
		
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		aList = as.appointmentList(pagination.getStartRow(), pagination.getEndRow(), si);
		System.out.println("AppointmentController appointmentList aList ->"+aList);
		
		// 시작시간 형태 전처리
	    aList.forEach(appointment -> {
	        String startTime = String.valueOf(appointment.getStart_time());
	        if (startTime.length() == 4) { // "1530" 같은 형식 처리
	            appointment.setStart_time(startTime.substring(0, 2) + ":" + startTime.substring(2));
	        }
	    });
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("aList", aList);
		model.addAttribute("type4", type4);
		model.addAttribute("type5", type5);
		model.addAttribute("search1", search1);
		
		return "admin/reservation";
	}
	
	
	// 예약 추가 뷰
	@GetMapping("/admin/addReservation")
	public String addAppointment() {
		return "admin/reservation_add";
	}
	
	// 예약 추가
	
	// 예약 상세 뷰
	@GetMapping("/admin/detailReservation")
	public String detailAppointment(@RequestParam(value = "resno", required = true) String resno,
									Model model)
	{ 
		System.out.println("/admin/detailReservation start ,,,");
		System.out.println("AppointmentController detailAppointment() start ,,,");
		System.out.println("AppointmentController detailAppointment() resno ->"+resno);
		
		// 예약 상세 불러오기 -> 여러가지가 아니라 한 개만 받아오면 돼서 객체로!
		Appointment appointment_d = new Appointment();
		
		appointment_d = as.appointmentDetail(resno);
		System.out.println("AppointmentController detailAppointment() appointment_d ->"+appointment_d);
		System.out.println("AppointmentController detailAppointment() appointment_d.status ->"+appointment_d.getStatus());
		
		model.addAttribute("appointment_d", appointment_d);
		
		return "admin/reservation_detail";
	}
	
	
	/**
	 * 관리자페이지 진료관리 뷰
	 * @return
	 */
	// 진료 관리 -> 예약상태가 '예약 확정 후 진료 완료' 인 경우의 데이터 불러오기 
	@GetMapping("admin/consultation")
	public String consultationList(
								@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pageNum,
								@RequestParam(value = "blockSize", required = false, defaultValue="10") String blockSize,
								@RequestParam(value = "type4", required = false, defaultValue = "0") int type4,
								Model model
								  )
	{
		System.out.println("admin/consultation start ,,,");
		System.out.println("AppointmentController consultationList() start ,,,");
		System.out.println("pagenNum ->"+pageNum);
		System.out.println("blockSize ->"+blockSize);
		System.out.println("type4 ->"+type4);
		
		List<Appointment> cList = new ArrayList<>();
		
		SearchItem si = new SearchItem(type4);
		
		int totalCnt = as.getTotalCntChart(si);
		
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		cList = as.consultationListChart(pagination.getStartRow(), pagination.getEndRow(), type4);
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("cList", cList);
		model.addAttribute("type4", type4);
		
		System.out.println(cList);
		System.out.println("type4 ->"+type4);
		
		return "admin/consultation";
	}
	
	
	

}
