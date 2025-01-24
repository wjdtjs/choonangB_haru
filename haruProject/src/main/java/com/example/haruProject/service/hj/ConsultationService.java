package com.example.haruProject.service.hj;

import java.util.List;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Chart;

public interface ConsultationService {

	Appointment		getConsultation(String resno);
	Chart 			getChart(String resno);
	int 			addChart(Chart ch);

	

}
