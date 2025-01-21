package com.example.haruProject.dao.hj;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Consultation;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ConsultationDaoImpl implements ConsultationDao {
	
	private final SqlSession session;

	@Override
	public Appointment getConsulatation(String resno) {
		System.out.println("ConsultationDaoImpl getConsulatation...");
		Appointment apm = null;
		
		try {
			apm = session.selectOne("HJSelectApointment", resno);
			System.out.println("ConsultationController addConsultation apm->"+apm);
		} catch (Exception e) {
			System.out.println("ConsultationDao getConsulatation error->"+e.getMessage());
		}
		return apm;
	}

	@Override
	public Consultation getChart(String resno) {
		System.out.println("ConsultationDaoImpl getConsulatation...");
		
		Consultation consult = null;
		try {
			consult = session.selectOne("HJSelectChart",resno);
		} catch (Exception e) {
			System.out.println("ConsultationDao getChart error->"+e.getMessage());
		}
		return consult;
	}

}
