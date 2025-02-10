package com.example.haruProject.controller.admin.hj;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.ScheRegularOff;
import com.example.haruProject.dto.Schedule;
import com.example.haruProject.service.hj.ScheduleService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ScheduleController {
	
	private final ScheduleService ss;
	
	@ResponseBody
	@GetMapping(value = "/api/getSchedule")
	public Map<String, Object> getSchedule(
											@RequestParam(value = "formattedDate", required = false) String current,
											@RequestParam(value = "formattedDateStart", required = false) String currentStart,
											@RequestParam(value = "formattedDateEnd", required = false) String currentEnd
											) {
		System.out.println("ScheduleController getSchedule ....");
		System.out.println("ScheduleController getSchedule current=->"+current);
		System.out.println("ScheduleController getSchedule currentEnd=->"+currentEnd);
		
		List<Schedule> schedules = new ArrayList();
		List<Schedule> reg_schedules = new ArrayList();
		// 병원휴무와 개인휴무
		schedules = ss.getScheduleList(current);
		// 의사 정기 휴무
		reg_schedules = ss.getRegScheduleList(currentEnd);
		
		// 의사 정기휴무 정보 (ano,현재휴무,변경휴무)
		for (int i = 0; i<reg_schedules.size();i++) {
			// 변경 날짜 가져오기
			Date docChangedOff = ss.getChangedOff(reg_schedules.get(i));
			reg_schedules.get(i).setNewoff(docChangedOff);
			System.out.println("ScheduleController getSchedule docChangedOff=->"+docChangedOff);
			List<String> offdays = ss.getDocOffdays(reg_schedules.get(i) ,currentEnd);
			reg_schedules.get(i).setPersoffdays(offdays);
		}
		

		
		Map<String, Object> schedule_map = new HashMap<>();
		schedule_map.put("schedules", schedules);
		
			
		schedule_map.put("reg_schedules", reg_schedules);
		
		System.out.println("ScheduleController getSchedule schedules-> " + schedules);
		System.out.println("ScheduleController getSchedule reg_schedules-> " + reg_schedules);
		
		return schedule_map;
	}

	
	@GetMapping(value = "/admin/addScheduleView")
	public String addScheduleView(Model model) {
		List<Common> schtypes = ss.getSchtypes();
		model.addAttribute("schtypes",schtypes);
		return "admin/addScheduleView";
	}
	
	@PostMapping(value = "/admin/addSchedule")
	public String addSchedule(Schedule schedule) {
		System.out.println("ScheduleController addSchedule");
		System.out.println("ScheduleController addSchedule schedule->"+schedule);
		
		int result = ss.insertSchedule(schedule);
		
		return "admin/schedule";
	}
	
	@ResponseBody
	@GetMapping(value = "/api/searchAname")
	public List<Admin> searchAname( @RequestParam("keyword") String keyword){
		List<Admin> adminList = ss.searchAdmin(keyword);
		
		return adminList;
	}
	
	@GetMapping(value = "/admin/detailSchedule")
	public String detailSchedule(@RequestParam("schno") int schno,
												Model model ) {
		Schedule schedule = ss.getSchedule(schno);
		
		System.out.println("ScheduleController detailSchedule");
		model.addAttribute("schedule",schedule);
		return "admin/detailSchedule";
	}
	
	@RequestMapping(value = "/admin/deleteSchedule")
	public String deleteSchedule(@RequestParam("schno") int schno) {
		System.out.println("ScheduleController deleteSchedule() ,,,");
		System.out.println("ScheduleController deleteSchedule() schno->"+schno);
		int result = ss.deleteSchedule(schno);
		System.out.println("ScheduleController deleteSchedule() result->"+result);
		
		return "admin/schedule";
	}
	
	@RequestMapping(value = "/admin/updateSchedule")
	public String updateSchedule(@RequestParam("schno") int schno,
								@RequestParam("schdate") String schdate,
								Model model) throws ParseException {
		System.out.println("ScheduleController updateSchedule() ,,,");
		
        
		Schedule sch = new Schedule();
		sch.setSchno(schno);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // String을 Date로 형변환
		sch.setSchdate(sdf.parse(schdate)); 
		
		int result = ss.updateSchedule(sch);
		System.out.println("ScheduleController updateSchedule() result->"+result);
		
		// 수정된 날짜를 모델에 추가
	    model.addAttribute("updatedDate", schdate);
		
		return "admin/schedule";
	}
}
