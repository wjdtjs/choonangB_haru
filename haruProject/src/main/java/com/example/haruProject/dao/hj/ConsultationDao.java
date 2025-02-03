package com.example.haruProject.dao.hj;

import java.util.List;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Chart;
import com.example.haruProject.dto.ChartDetail;

public interface ConsultationDao {

	Appointment 		getConsulatation(String resno);
	Chart 				getChart(String resno);
	int 				addChart(Chart ch);
	int					chartImgSave(List<String> imgPaths, Chart ch);
	List<ChartDetail> 	getChartImage(String resno);
	
	Appointment			userDetailConsultation(String cno);
	Chart 				userChart(String cno);
	List<ChartDetail>	userChartImages(String cno);

}
