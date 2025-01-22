package com.example.haruProject.dao.hr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class AppointmentDaoImp implements AppointmentDao {
	private final SqlSession session;
	
	// 예약 목록 전체 수
	@Override
	public int getTotalCnt(SearchItem si) {
		System.out.println("AppointmentDaoImp getTotalCnt() start ,,,");
		System.out.println("AppointmentDaoImp getTotalCnt() si ->"+si);
		
		int totalCnt = 0;
		
		try {
			totalCnt = session.selectOne("HR_SelectTotalAppointmentCnt", si);
			System.out.println("totalCnt ->" +totalCnt);
		} catch (Exception e) {
			log.error("getTotalCnt() error ->", e);
		}
		return totalCnt;
	}

	// 예약 목록 가져오기(페이지네이션)
	@Override
	public List<Appointment> appointmentList(int startRow, int endRow, SearchItem si) {
		System.out.println("AppointmentDaoImp appointmentList() start ,,,");
		System.out.println("AppointmentDaoImp appointmentList() si ->"+si);
		
		List<Appointment> alist = new ArrayList<>();
		
		Map<String , Object> aMap = new HashMap<>();
		aMap.put("startRow", startRow);
		aMap.put("endRow", endRow);
		aMap.put("si", si);
		
		try {
			System.out.println("aMap ->"+aMap);
			alist = session.selectList("HR_SelectAppointmentList", aMap);
			System.out.println("alist ->"+alist);
		} catch (Exception e) {
			log.error("appointmentList() error ->", e);
		}
		return alist;
	}

	// 예약 상세 가져오기
	@Override
	public Appointment appointmentDetail(String resno) {
		System.out.println("AppointmentDaoImp appointmentDetail() start ,,,");
		System.out.println("AppointmentDaoImp appointmentDetail() resno ->"+resno);
		
		Appointment appointment_d = new Appointment();
		
		try {
			appointment_d = session.selectOne("HR_SelectAppointmentDetail", resno);
			System.out.println("AppointmentDaoImp appointmentDetail() appointment_d ->"+appointment_d);
		} catch (Exception e) {
			log.error("appointmentDetail() error ->", e);
		}
		
		return appointment_d;
	}
	
	// 예약 수정하기
	@Override
	public int updateReservation(String resno, int rtime, String memo, int status) {
		System.out.println("AppointmentDaoImp updateReservation() start ,,,");
		System.out.println("AppointmentDaoImp updateReservation() resno ->"+resno);
		System.out.println("AppointmentDaoImp updateReservation() rtime ->"+rtime);
		System.out.println("AppointmentDaoImp updateReservation() memo ->"+memo);
		System.out.println("AppointmentDaoImp updateReservation() status ->"+status);
		
		Map<String, Object> rMap = new HashMap<>();
		rMap.put("resno", resno);
		rMap.put("rtime", rtime);
		rMap.put("memo", memo);
		rMap.put("status", status);
		
		int result = 0;
		
		try {
			result = session.update("HR_UpdateReservation", rMap);
		} catch (Exception e) {
			log.error("updateReservation() error ->", e);
		}
		
		return result;
	}


	
	
	// 진료 목록 전체 수
	@Override
	public int getTotalCntChart(SearchItem si) {
		System.out.println("AppointmentDaoImp getTotalCntChart() start ,,,");
		System.out.println("AppointmentDaoImp getTotalCntChart() si ->"+si);
		
		int totalCnt = 0;
		
		try {
			totalCnt = session.selectOne("HR_SelectTotalConsultationCnt", si);
			System.out.println("AppointmentDaoImp getTotalCntChart() totalCnt ->"+totalCnt);
		} catch (Exception e) {
			log.error("getTotalCntChart() error ->", e);
		}
		return totalCnt;
	}

	// 진료 목록 가져오기 (페이지네이션)
	@Override
	public List<Appointment> consultationListChart(int startRow, int endRow, SearchItem si) {
		System.out.println("AppointmentDaoImp consultationListChart() start ,,,");
		System.out.println("AppointmentDaoImp getTotalCntChart() si ->"+si);
		List<Appointment> clist = new ArrayList<>();
		
		Map<String, Object> cMap = new HashMap<>();
		cMap.put("startRow", startRow);
		cMap.put("endRow", endRow);
		cMap.put("si", si);
		
		try {
			clist = session.selectList("HR_SelectConsultationList", cMap);
			System.out.println("AppointmentDaoImp getTotalCntChart()  cList ->"+clist);
		} catch (Exception e) {
			log.error("consultationListChart() error ->", e);
		}
		return clist;
	}	


}
