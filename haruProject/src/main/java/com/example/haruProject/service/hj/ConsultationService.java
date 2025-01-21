package com.example.haruProject.service.hj;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Consultation;

public interface ConsultationService {

	Appointment		getConsultation(String resno);
	Consultation 	getChart(String resno);

	

}
