package com.example.haruProject.controller.admin.hj;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.service.hj.ConsultationService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ConsultationController {
	
	private final ConsultationService cs;
	
	@RequestMapping(value = "/admin/addConsultation")
	public String addConsultation(@RequestParam("resno") String resno, Model model) {
		
		System.out.println("ConsultationController addConsultation ...");
		System.out.println("ConsultationController addConsultation resno->"+resno);
		Appointment apm =  cs.getConsultation(resno);
		
		model.addAttribute("apm",apm);
		
		return "admin/addConsultation";
	}

}
