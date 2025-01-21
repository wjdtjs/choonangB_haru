package com.example.haruProject.service.hj;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.ConsultationDao;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Consultation;

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
	public Consultation getChart(String resno) {
		System.out.println("ConsultationServiceImpl getChart...");
		Consultation consult = cd.getChart(resno);
		return consult;
	}

}
