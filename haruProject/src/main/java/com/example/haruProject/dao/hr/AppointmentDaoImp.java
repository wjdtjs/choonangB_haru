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
		List<Appointment> alist = new ArrayList<>();
		
		Map<String , Object> aMap = new HashMap<>();
		aMap.put("startRow", startRow);
		aMap.put("endRow", endRow);
		aMap.put("si", si);
		
		try {
			alist = session.selectList("HR_SelectAppointmentList", aMap);
		} catch (Exception e) {
			log.error("appointmentList() error ->", e);
		}
		return alist;
	}

	
	
	// 진료 목록 전체 수
	@Override
	public int getTotalCntChart() {
		int totalCnt = 0;
		
		try {
			totalCnt = session.selectOne("HR_SelectTotalConsultationCnt");
		} catch (Exception e) {
			log.error("getTotalCntChart() error ->", e);
		}
		return totalCnt;
	}

	// 진료 목록 가져오기 (페이지네이션)
	@Override
	public List<Appointment> consultationListChart(int startRow, int endRow) {
		System.out.println("AppointmentDaoImp consultationListChart() start ,,,");
		List<Appointment> clist = new ArrayList<>();
		
		Map<String, Object> cMap = new HashMap<>();
		cMap.put("startRow", startRow);
		cMap.put("endRow", endRow);
		
		try {
			clist = session.selectList("HR_SelectConsultationList", cMap);
		} catch (Exception e) {
			log.error("consultationListChart() error ->", e);
		}
		return clist;
	}



}
