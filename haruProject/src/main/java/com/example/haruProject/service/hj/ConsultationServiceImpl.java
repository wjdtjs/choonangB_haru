package com.example.haruProject.service.hj;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.ConsultationDao;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Chart;

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

}
