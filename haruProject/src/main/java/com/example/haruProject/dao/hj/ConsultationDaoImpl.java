package com.example.haruProject.dao.hj;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Appointment;

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

}
