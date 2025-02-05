package com.example.haruProject.controller.admin.hj;

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
	@GetMapping(value = "/admin/api/getSchedule")
	public Map<String, Object> getSchedule(@RequestParam(value = "current", required = false) String current) {
		System.out.println("ScheduleController getSchedule ....");
		System.out.println("ScheduleController getSchedule current=->"+current);
		List<Schedule> schedules = new ArrayList();
		List<Schedule> reg_schedules = new ArrayList();
		// 병원휴무와 개인휴무
		schedules = ss.getScheduleList();
		reg_schedules = ss.getRegScheduleList();
		
		// 의사 정기휴무 정보 (ano,현재휴무,변경휴무)
		List<ScheRegularOff> docRegOff = ss.getDocOffInfo();
		// 오늘부터 두달간 의사 휴무
		for(int i = 0; i < docRegOff.size(); i++) {
			ScheRegularOff regOffnfo = docRegOff.get(i);
			
			List<Date> offdays = ss.getDocOffdays(regOffnfo);
			
			regOffnfo.setPersoffdays(offdays);
		}
		

		
		Map<String, Object> schedule_map = new HashMap<>();
		schedule_map.put("schedules", schedules);
		schedule_map.put("docRegOff", docRegOff);
		
		System.out.println("ScheduleController getSchedule schedules-> " + schedules);
		System.out.println("ScheduleController getSchedule docRegOff-> " + docRegOff);
		
		return schedule_map;
	}

	@GetMapping(value = "/admin/addScheduleView")
	public String addScheduleView(Model model) {
		List<Common> schtypes = ss.getSchtypes();
		model.addAttribute("schtypes",schtypes);
		return "admin/addScheduleView";
	}
}
