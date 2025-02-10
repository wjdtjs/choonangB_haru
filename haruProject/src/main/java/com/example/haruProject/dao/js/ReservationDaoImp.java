package com.example.haruProject.dao.js;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Schedule;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class ReservationDaoImp implements ReservationDao {
	
	private final SqlSession session;
	
	/**
	 * 반려동물 리스트
	 */
	@Override
	public List<Pet> getPetList(int memno) {
		List<Pet> petList = new ArrayList<>();
		
		try {
			petList = session.selectList("HJSelectMyPets", memno);
		} catch (Exception e) {
			log.error("getPetList() query error -> ", e);
		}
		
		return petList;
	}

	/**
	 * totalCnt
	 */
	@Override
	public int getResTotalCnt(Map<String, Object> params) {
		int totalCnt = 0;
		try {
			totalCnt = session.selectOne("JS_SelectReservationTotalCnt", params);
		} catch (Exception e) {
			log.error("getResTotalCnt() query error -> ", e);
		}
		return totalCnt;
	}

	/**
	 * 예약 리스트
	 */
	@Override
	public List<Appointment> getReservation(Map<String, Object> params) {
		List<Appointment> resList = new ArrayList<>();
		try {
			resList = session.selectList("JS_SelectReservationList", params);
		} catch (Exception e) {
			log.error("getReservation() query error -> ", e);
		}
		
		return resList;
	}

	/**
	 * 진료 항목 bcd
	 */
	@Override
	public List<Common> getBCDList() {
		List<Common> list = new ArrayList<>();
		try {
			list = session.selectList("JS_SelectConsultationBcdList");
		} catch (Exception e) {
			log.error("getBCDList() query error -> ", e);
		}
		
		return list;
	}

	/**
	 * 의사 정기 휴무 정보
	 */
	@Override
	public List<Schedule> getDayOffSchedule(Map<String, Object> d) {
		List<Schedule> list = new ArrayList<>();
		
		System.out.println("getDayOffSchedule new Date ======>"+ new Date());
		
		try {
			list = session.selectList("JS_SelectDoctorDayOff", d);
		} catch (Exception e) {
			log.error("getDayOffSchedule() query error -> ", e);
		}
		return list;
	}

	/**
	 * 의사 정기 휴무
	 */
	@Override
	public List<Schedule> getRegScheduleList(int ano, String currentEnd) {
		System.out.println("getRegScheduleList() ano ======> "+ano);
		System.out.println("getRegScheduleList() currentEnd ======> "+currentEnd);
		
		List<Schedule> list = new ArrayList<>();
		Map<String, Object> pMap = new HashMap<>();
		
//		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//		String formattedDate = formatter.format(currentEnd); 
//		System.out.println("formattedDate ====> "+ formattedDate);
		
		pMap.put("ANO", ano);
		pMap.put("current", currentEnd);
		
		try {
			list = session.selectList("JS_SelectDoctorDayOff2", pMap);
		} catch (Exception e) {
			log.error("getRegScheduleList() query error -> ", e);
		}
		
		return list;
	}

	/**
	 * 예약 하기
	 */
	@Override
	public void doAppointmentAction(Appointment app) {
		System.out.println("dao doAppointmentAction() application => "+app);
		
		try {
			session.insert("JS_InsertAppointment", app);
		} catch (Exception e) {
			log.error("doAppointmentAction() query error -> ", e);
		}
	}

}
