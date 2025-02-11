package com.example.haruProject.service.hj;

import java.util.List;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Chart;
import com.example.haruProject.dto.ChartDetail;

public interface ConsultationService {

	Appointment			getConsultation(String resno);
	Chart 				getChart(String resno);
	int 				addChart(Chart ch);
	int					chartImgSave(List<String> imgPaths, Chart ch);
	List<ChartDetail> 	getImages(String resno);

	Appointment 		userDetailConsultation(String cno);
	Chart 				getUserChart(String cno);
	List<ChartDetail> 	getUserImages(String cno);
	void 				updateConsultation(Chart ch, List<String> imgPaths);

	

}
