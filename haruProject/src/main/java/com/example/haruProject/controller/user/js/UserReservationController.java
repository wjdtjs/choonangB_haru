package com.example.haruProject.controller.user.js;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.service.js.ReservationService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class UserReservationController {
	
	private final ReservationService rs;
	
	/**
	 * 예약내역 리스트 조회
	 * @param start
	 * @param end
	 * @param petno
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping("/user/reservation")
	public String reservationView(@RequestParam(value="start", required = false) String start,
								@RequestParam(value="end", required = false) String end,
								@RequestParam(value="petno", required = true, defaultValue = "0") String petno,
								@RequestParam(value="pageNum", required = false, defaultValue = "1") String pageNum,
								@RequestParam(value="blockSize", required = false, defaultValue = "30") int blockSize,
								HttpServletRequest request, Model model) 
	{
		log.info("reservationView() start..");
		
		//회원번호
		int memno = SessionUtil.getNo(request);
		
		//반려동물 리스트
		List<Pet> petList = new ArrayList<>();
		petList = rs.getPetList(memno);
		
		//예약내역
		List<Appointment> resList = new ArrayList<>();
		
		Map<String, Object> params = new HashMap<>();		
		params.put("memno", memno);
		params.put("petno", petno);
		params.put("start", start);
		params.put("end", end);

		//예약내역 전체 수
		int totalCnt = rs.getResTotalCnt(params);
		System.out.println("reservationView() 전체 수 "+totalCnt);
		
		Pagination page = new Pagination(totalCnt, pageNum, blockSize);
		params.put("page", page);
		
		System.out.println("Map params== "+params);
		resList = rs.getReservation(params);
		System.out.println("reservationView() 예약내역 "+resList);
		
		//현재 날짜
		Date now = new Date();
		
		List<Appointment> pre_list  = new ArrayList<>(); //앞둔 예약 리스트
		List<Appointment> past_list = new ArrayList<>(); //이전 예약 리스트
		for(Appointment a: resList) {
			if(a.getRdate().before(now) ) { //이전 예약
				past_list.add(a);
			} else { //앞둔 예약
				pre_list.add(a);
			}
		}
		
	
		model.addAttribute("petno", petno);
		model.addAttribute("start", start);
		model.addAttribute("end", end);
		model.addAttribute("pet", petList);
		model.addAttribute("pre", pre_list);
		model.addAttribute("past", past_list);
		
		return "user/reservation";
	}
}
