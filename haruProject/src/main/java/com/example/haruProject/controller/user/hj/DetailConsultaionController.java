package com.example.haruProject.controller.user.hj;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Chart;
import com.example.haruProject.dto.ChartDetail;
import com.example.haruProject.service.hj.ConsultationService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class DetailConsultaionController {
	private final ConsultationService cs;
	
	@RequestMapping(value = "/user/detailConsultation")
	public String DetailConsultationView( @RequestParam("cno") String cno,
										Model model) {
		System.out.println("DetailConsultationView ...");
		
		Appointment apm = cs.userDetailConsultation(cno);
		Chart chart = cs.getUserChart(cno);
		List<ChartDetail> imageLists = cs.getUserImages(cno);
		
		model.addAttribute("apm",apm);
		model.addAttribute("chart",chart);
		model.addAttribute("imageLists",imageLists);
		
		model.addAttribute("apm",apm);
		return "user/detailConsultation";
	}

}
