package com.example.haruProject.dao.hj;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Chart;

public interface ConsultationDao {

	Appointment 	getConsulatation(String resno);
	Chart 			getChart(String resno);
	int 			addChart(Chart ch);

}
