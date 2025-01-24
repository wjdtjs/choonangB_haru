package com.example.haruProject.dao.hj;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Chart;

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
	public Chart getChart(String resno) {
		System.out.println("ConsultationDaoImpl getConsulatation...");
		
		Chart result = null;
		try {
			result = session.selectOne("HJSelectChart",resno);
			System.out.println("ConsultationDaoImpl getConsulatation result ->"+result);
		} catch (Exception e) {
			System.out.println("ConsultationDao getChart error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int addChart(Chart ch) {
		System.out.println("ConcultationDao addChart ...");
		
		int result = 0;
		try {
			result = session.insert("HJInsertChart",ch);

		} catch (Exception e) {
			System.out.println("ConsultationDao addChart error->"+e.getMessage());
		}
		return result;
	}

}
