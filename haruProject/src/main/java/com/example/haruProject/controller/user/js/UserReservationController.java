package com.example.haruProject.controller.user.js;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Schedule;
import com.example.haruProject.service.hj.ScheduleService;
import com.example.haruProject.service.hr.AppointmentService;
import com.example.haruProject.service.hr.NotificationService;
import com.example.haruProject.service.js.ReservationService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class UserReservationController {
	
	private final ReservationService rs;
	private final AppointmentService as;
	private final ScheduleService ss;
	private final NotificationService ns;
	
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
	
	
	/**
	 * 예약 
	 * step1 : 동물, 예약 항목 선택 페이지
	 * @param appointment
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/user/appointment")
	public String appointmentStep1View(Appointment appointment, Model model, HttpServletRequest request) {
		log.info("appointmentStep1 start..");
		int memno = SessionUtil.getNo(request);
		
		//예약 항목 가져오기 (bcd)
		List<Common> bcdList = new ArrayList<>();
		bcdList = rs.getBCDList();
		System.out.println("예약항목=== "+bcdList);
		
		//동물 정보 가져오기
		List<Pet> petList = new ArrayList<>();
		petList = rs.getPetList(memno);
		
		model.addAttribute("bcd", bcdList);
		model.addAttribute("pet", petList);
		
		return "user/appointment";
	}
	
	
	/**
	 * 예약
	 * step2 : 선생님, 날짜, 시간 선택 페이지
	 * @param bcd
	 * @param mcd
	 * @param memo
	 * @param pet
	 * @return
	 */
	@PostMapping("/user/appointmentStep1")
	public String appointmentStep2View(@RequestParam(value = "apt_bcd") String bcd,
									@RequestParam(value = "apt_mcd") String mcd,
									@RequestParam(value = "memo", required = false) String memo,
									Pet pet, Model model, HttpServletRequest request) 
	{
		log.info("appointmentStep2View() start..");
		
		System.out.println("appointmentStep2View() bcd -> "+bcd);
		System.out.println("appointmentStep2View() mcd -> "+mcd);
		System.out.println("appointmentStep2View() memo -> "+memo);
		System.out.println("appointmentStep2View() pet -> "+pet);
		
		String name = SessionUtil.getName(request);
		
		List<Map<String, Object>> docList = new ArrayList<>(); 	//의사 정보
		List<List<Schedule>> dayOffList = new ArrayList<>();	//의사 휴무 정보
		List<Schedule> docDayOffList = new ArrayList<>();		//
		
		docList = as.getDocList();
		
		for(Map<String, Object> d : docList) {
			docDayOffList = rs.getDayOffSchedule(d);	
			dayOffList.add(docDayOffList);
		}
		System.out.println("appointmentStep2View() doctorList -> "+docList);
		System.out.println("appointmentStep2View() dayOffList -> "+dayOffList);
		
		Map<String, Object> am = new HashMap<>();
		
		am.put("name", name);
		am.put("bcd_cont", bcd);
		am.put("mcd_cont", mcd);
		am.put("bcd", pet.getBcd());
		am.put("mcd", pet.getMcd());
		am.put("memo", memo);
		am.put("petname", pet.getPetname());
		am.put("petno", pet.getPetno());
		am.put("ano", pet.getAno());
		am.put("doctor", docList);
		
		model.addAttribute("apt", am);
		model.addAttribute("dayoff", dayOffList);
		return "user/appointment2";
	}
	
	/**
	 * 의사 정기 휴무 날짜
	 * @param ano
	 * @param current
	 * @param currentEnd
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/api/vet-regular-holiday")
	public List<Schedule> getSchedule(@RequestParam(value = "ano", required = true) int ano,
									@RequestParam(value = "formattedDateEnd", required = false) String currentEnd) 
	{
		System.out.println("getSchedule() start...");
		System.out.println("getSchedule() ano=->"+ano);
		System.out.println("getSchedule() currentEnd=->"+currentEnd);
		
		List<Schedule> reg_schedules = new ArrayList<>();

		// 의사 정기 휴무
		reg_schedules = rs.getRegScheduleList(ano, currentEnd);
		System.out.println("getSchedule() 의사 휴무 일정 리스트 : " + reg_schedules);
		
		// 의사 정기휴무 정보 (ano,현재휴무,변경휴무)
		for (int i = 0; i<reg_schedules.size();i++) {
			// 변경 날짜 가져오기
			Date docChangedOff = ss.getChangedOff(reg_schedules.get(i));
			reg_schedules.get(i).setNewoff(docChangedOff);
			List<String> offdays = ss.getDocOffdays(reg_schedules.get(i) ,currentEnd);
			reg_schedules.get(i).setPersoffdays(offdays);
			System.out.println("ScheduleController getSchedule docChangedOff=->"+docChangedOff);
		}
		
		System.out.println("getSchedule() reg_schedules-> " + reg_schedules);
		
		return reg_schedules;
	}
	
	/**
	 * 예약 하기
	 * @param request
	 * @param app
	 * @param model
	 * @return
	 */
	@PostMapping("/user/appointmentStep2")
	public String appointmentAction(HttpServletRequest request, Appointment app, Model model) {
		log.info("appointmentAction() start..");
		System.out.println("appointmentAction() 예약=> "+app);
		
		int memno = SessionUtil.getNo(request);
		app.setMemno(memno);
		
		System.out.println("controller*********mtitle_bcd => "+app.getMtitle_bcd());
		System.out.println("controller*********mtitle_mcd => "+app.getMtitle_mcd());
		rs.doAppointmentAction(app);
		
		
		return "redirect:/user/reservation";
	}

}
