package com.example.haruProject.service.hj;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.ConsultationDao;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Chart;
import com.example.haruProject.dto.ChartDetail;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ConsultationServiceImpl implements ConsultationService {
	
	private final ConsultationDao cd;

	@Override
	public Appointment getConsultation(String resno) {
		System.out.println("ConsultationServiceImpl getConsultation...");
		Appointment apm = cd.getConsulatation(resno);
		return apm;
	}

	@Override
	public Chart getChart(String resno) {
		System.out.println("ConsultationServiceImpl getChart...");
		Chart chart = cd.getChart(resno);
		return chart;
	}

	@Override
	public int addChart(Chart ch) {
		System.out.println("ConsultationService addChart ...");
		int result = cd.addChart(ch);
		return result;
	}

	@Override
	public int chartImgSave(List<String> imgPaths, Chart ch) {
		System.out.println("ConsultationService addChart ...");
		int imgResult = cd.chartImgSave(imgPaths,ch);
		return imgResult;
	}

	@Override
	public List<ChartDetail> getImages(String resno) {
		System.out.println("ConsultationService addChart ...");
		List<ChartDetail> imgList = cd.getChartImage(resno);
		return imgList;
	}

	@Override
	public Appointment userDetailConsultation(String cno) {
		System.out.println("ConsultationService userDetailConsultation ...");
		Appointment apm = cd.userDetailConsultation(cno);
		
		return apm;
	}

	@Override
	public Chart getUserChart(String cno) {
		System.out.println("Consultaion getUserChart ...");
		Chart chart = cd.userChart(cno);
		return chart;
	}

	@Override
	public List<ChartDetail> getUserImages(String cno) {
		System.out.println("Consultation getUserImage...");
		List<ChartDetail> imageLists = cd.userChartImages(cno);
		return imageLists;
	}


}
