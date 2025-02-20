package com.example.haruProject.controller.admin.hr;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Schedule;
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
						@RequestParam(value = "type5", required = true, defaultValue = "100") int type5,
						@RequestParam(value = "search4", required = false, defaultValue = "0") int search4,
						@RequestParam(value = "start_date", required = false, defaultValue="") String start_date,
						@RequestParam(value = "end_date", required = false, defaultValue = "") String end_date,
						Model model
						) 
	{
		System.out.println("/admin/reservation start ,,,");
		System.out.println("AppointmentController appointmentList() start ,,,");
		System.out.println("AppointmentController appointmentList() search1 ->"+search1);
		System.out.println("AppointmentController appointmentList() type4 ->"+type4);
		System.out.println("AppointmentController appointmentList() type5 ->"+type5);
		System.out.println("AppointmentController appointmentList() start_date ->"+start_date);
		System.out.println("AppointmentController appointmentList() end_date ->"+end_date);
		
		List<Appointment> aList = new ArrayList<>();
		
		SearchItem si = new SearchItem(type4, type5, search1, start_date, end_date, search4);
		
		int totalCnt = as.getTotalCnt(si);
		
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		aList = as.appointmentList(pagination.getStartRow(), pagination.getEndRow(), si);
		System.out.println("AppointmentController appointmentList aList ->"+aList);
		
		// 시작시간 형태 전처리
	    aList.forEach(appointment -> {
	        String startTime = String.valueOf(appointment.getStart_time());
	        if (startTime.length() == 4) { // 1530 -> 15:30
	            appointment.setStart_time(startTime.substring(0, 2) + ":" + startTime.substring(2));
	        }
	    });
		
	    model.addAttribute("search4", search4);
		model.addAttribute("pagination", pagination);
		model.addAttribute("aList", aList);
		model.addAttribute("type4", type4);
		model.addAttribute("type5", type5);
		model.addAttribute("search1", search1);
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		
		return "admin/reservation";
	}
	
	
	// 예약 추가 뷰
	// + 예약 항목 대분류 가져오기
	// + 진료 가능 선생님 가져오기
	@GetMapping("/admin/addReservation")
	public String addAppointment(Model model) {
		System.out.println("AppointmentController /admin/addReservation start ,,,");
		System.out.println("AppointmentController addAppointment start ,,,");
		
		List<Map<String, Object>> bcdList = new ArrayList<>();
		List<Map<String, Object>> docList = new ArrayList<>();
		bcdList = as.getBCDList();
		docList = as.getDocList();
		System.out.println("docList ->"+docList);
		
		model.addAttribute("bcdList", bcdList);
		model.addAttribute("docList", docList);
		
		return "admin/reservation_add";
	}
	
	// 예약 항목 중분류 가져오기
	@ResponseBody
	@GetMapping("/api/res-mcd/{bcd}")
	public List<Map<String, Object>> reservationMCD(@PathVariable("bcd") int bcd) {
		System.out.println("AppointmentController reservationMCD() start ,,,");
		
		List<Map<String, Object>> mcdList = new ArrayList<>();
		mcdList = as.getMCDList(bcd);
		
		return mcdList;
	}
	
	// 예약 불가능 날짜 불러오기
	@ResponseBody
	@GetMapping("/api/disabled-dates")
	public List<Schedule> getDisabledDates(@RequestParam(value = "ano", required = true) int ano,
										@RequestParam(value="month", defaultValue = "0") int month) 
	{
		System.out.println("AppointmentController getDisabledDates() start ,,,");
		System.out.println("AppointmentController getDisabledDates() ano ->"+ano);
		System.out.println("AppointmentController getDisabledDates() month ->"+month);
		
		//이번달 것만 가지고오기
		List<Schedule> sList = as.getDisabledDatesList(ano, month);

		Date today = new Date();
		
		int mm = today.getMonth()+1;
		int today_date = today.getDate();
		if(mm == month) {
			for (int day = 1; day <= today_date; day++) {
				Schedule prevToday = new Schedule();
				Date dd = new Date(today.getYear(), today.getMonth(), day);
				
				prevToday.setSchdate(dd);
				sList.add(prevToday);
			}			
		}
        
		return sList;
	}
	
	// 날짜에 따른 불가능 시간 불러오기
	@ResponseBody
	@GetMapping("/api/disabled-times")
	public List<Appointment> getDisabledTimes(@RequestParam(value = "rdate", required = true) String rdate,
											  @RequestParam(value = "ano", required = true) int ano) throws ParseException {
		System.out.println("AppointmentController getDisabledTimes() start ,,,");
		System.out.println("AppointmentController getDisabledTimes() rdate ->"+rdate);
		System.out.println("AppointmentController getDisabledTimes() ano ->"+ano);

		System.out.println("AppointmentController getDisabledTimes() rdate ->"+rdate);
		
		List<Appointment> aList = as.getDisabledTimesList(rdate, ano);
		System.out.println("AppointmentController getDisabledTimes() aList ->"+aList);
		
		return aList;		
	}
	
	// 보호자 이름 불러오기
	@ResponseBody
	@GetMapping("/api/mname/{search1}")
	public List<Map<String, Object>> reservationMname(@PathVariable("search1") String search1) {
		System.out.println("AppointmentController reservationMname() start ,,,");
		System.out.println("AppointmentController reservationMname() search1 ->"+search1);
		
		List<Map<String, Object>> mnameList = new ArrayList<>();
		mnameList = as.getMnameList(search1);
		
		// mtel 전처리
	       for (Map<String, Object> item : mnameList) {
	          String processedMtel = null;
	           if (item.containsKey("MTEL")) {
	               String mtel = (String) item.get("MTEL");

	               processedMtel = mtel.replaceAll("^.*(\\d{4})$", "$1");
	               System.out.println("processedMtel ->"+processedMtel);

	               
	           } else {
	              processedMtel = (String) item.get("MEMAIL");
	           }
	           item.put("MTEL", processedMtel);
	       }

	    // 처리된 결과 확인
	    System.out.println("AppointmentController reservationMname() mnameList -> " + mnameList);

		
		return mnameList;
	}
	
	// 보호자 선택시 보호자에 해당하는 동물 불러오기
	@ResponseBody
	@GetMapping("/api/petname/{memno}")
	public List<Map<String, Object>> reservationPetname(@PathVariable("memno") int memno) {
		System.out.println("AppointmentController reservationPetname() start ,,,");
		System.out.println("AppointmentController reservationPetname() memno ->"+memno);
		
		List<Map<String, Object>> petnameList = new ArrayList<>();
		petnameList = as.getPetnameList(memno);
		
		for(Map<String, Object> item : petnameList) {
			if(item.containsKey("PETBIRTH")) {
				Date petbirth = (Date) item.get("PETBIRTH");
				
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy-MM-dd");
				String processedPetbirth = simpleDateFormat.format(petbirth);	// yy-mm-dd
				System.out.println("processedPetbirth ->"+processedPetbirth);
				
				item.put("PETBIRTH", processedPetbirth);
			}
		}
		
		System.out.println("AppointmentController reservationPetname() petnameList ->"+petnameList);
		
		return petnameList;
	}
	
	
	// 예약 추가
	@RequestMapping("/admin/insertReservation")
	public String insertReservation(@ModelAttribute Appointment appointment)
	{
		System.out.println("/admin/insertReservation start ,,,");
		System.out.println("AppointmentController insertReservation() start ,,,");
		System.out.println("AppointmentController insertReservation() appointment ->"+appointment);
		
		as.insertReservation(appointment);
		
		return "redirect:/admin/reservation";
	}
	

	
	
	
	
	
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
		System.out.println("AppointmentController detailAppointment() appointment_d.resno ->"+appointment_d.getResno());
		System.out.println("AppointmentController detailAppointment() appointment_d.cresno ->"+appointment_d.getCresno());
		
		String startTime = String.valueOf(appointment_d.getStart_time());
        if (startTime.length() == 4) { // 1530 -> 15:30
        	appointment_d.setStart_time(startTime.substring(0, 2) + ":" + startTime.substring(2));
        }
		
		model.addAttribute("appointment_d", appointment_d);
		
		return "admin/reservation_detail";
	}
	
	/**
	 * 예약 상세 수정
	 * - 예약 대기 : 예약 확정, 예약 취소
	 * - 예약 확정 : 예약 변경, 예약 취소, 진료 완료
	 */
	
	@RequestMapping("/admin/updateReservation")
	public String updateReservation(@RequestParam("resno") String resno,
									 @RequestParam("rtime") int rtime,
									 @RequestParam("memo") String memo,
									 @RequestParam("status") int status,	// 변경할 상태 번호
									 @RequestParam("memail") String memail,
									 Model model
									 ) {
		System.out.println("AppointmentController updateReservation() start ,,,");
		System.out.println("AppointmentController updateReservation() resno ->"+resno);
		System.out.println("AppointmentController updateReservation() rtime ->"+rtime);
		System.out.println("AppointmentController updateReservation() memo ->"+memo);
		System.out.println("AppointmentController updateReservation() status ->"+status);
		System.out.println("AppointmentController updateReservation() memail ->"+memail);
		
		if (status == 300) {
			return "redirect:/mail/cancelSend?memail="+memail+"&rtime="+rtime+"&resno="+resno
					+"&memo="+memo+"&status="+status;
		} else {
			int result = as.updateReservation(resno, rtime, memo, status);
			System.out.println("AppointmentController confirmReservation() result ->"+result);
			return "redirect:/admin/reservation";
		}
				
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
								@RequestParam(value = "search1", required = false, defaultValue = "") String search1,
								@RequestParam(value = "type5", required = true, defaultValue = "100") int type5,
								@RequestParam(value = "start_date", required = false, defaultValue="") String start_date,
								@RequestParam(value = "end_date", required = false, defaultValue = "") String end_date,
								Model model
								  )
	{
		System.out.println("admin/consultation start ,,,");
		System.out.println("AppointmentController consultationList() start ,,,");
		System.out.println("pagenNum ->"+pageNum);
		System.out.println("blockSize ->"+blockSize);
		System.out.println("type4 ->"+type4);
		System.out.println("search1 ->"+search1);
		System.out.println("type5 ->"+type5);
		System.out.println("start_date ->"+start_date);
		System.out.println("end_date ->"+end_date);
		
		List<Appointment> cList = new ArrayList<>();
		
		SearchItem si = new SearchItem(type4, type5, search1, start_date, end_date);
		
		int totalCnt = as.getTotalCntChart(si);
		
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		cList = as.consultationListChart(pagination.getStartRow(), pagination.getEndRow(), si);
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("cList", cList);
		model.addAttribute("type4", type4);
		model.addAttribute("search1", search1);
		model.addAttribute("type5", type5);
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		
		System.out.println(cList);
		System.out.println("type4 ->"+type4);
		System.out.println("search1 ->"+search1);
		System.out.println("type5 ->"+type5);
		System.out.println("start_date ->"+start_date);
		System.out.println("end_date ->"+end_date);
		
		return "admin/consultation";
	}
	
	
	

}
