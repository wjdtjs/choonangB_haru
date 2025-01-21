package com.example.haruProject.dao.hj;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Consultation;

public interface ConsultationDao {

	Appointment 	getConsulatation(String resno);
	Consultation 	getChart(String resno);

}
