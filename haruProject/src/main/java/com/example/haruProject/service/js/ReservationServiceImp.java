package com.example.haruProject.service.js;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.js.ReservationDao;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Schedule;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReservationServiceImp implements ReservationService {
	
	private final ReservationDao rd;
	
	/**
	 * 반려동물 리스트
	 */
	@Override
	public List<Pet> getPetList(int memno) {
		List<Pet> petList = new ArrayList<>();
		petList = rd.getPetList(memno);
		
		return petList;
	}

	/**
	 * totalCnt
	 */
	@Override
	public int getResTotalCnt(Map<String, Object> params) {
		int totalCnt = rd.getResTotalCnt(params);
		return totalCnt;
	}

	/**
	 * 예약 리스트
	 */
	@Override
	public List<Appointment> getReservation(Map<String, Object> params) {
		List<Appointment> resList = new ArrayList<>();
		resList = rd.getReservation(params);
		return resList;
	}

	/**
	 * 예약 항목 리스트 (수술 제외)
	 */
	@Override
	public List<Common> getBCDList() {
		List<Common> list = new ArrayList<>();
		list = rd.getBCDList();
		return list;
	}

	/**
	 * 의사 정기 휴무 정보
	 */
	@Override
	public List<Schedule> getDayOffSchedule(Map<String, Object> d) {
		List<Schedule> list = new ArrayList<>();
		list = rd.getDayOffSchedule(d);
		return list;
	}

	/**
	 * 의사 정기 휴무
	 */
	@Override
	public List<Schedule> getRegScheduleList(int ano, String currentEnd) {
		List<Schedule> list = new ArrayList<>();
		list = rd.getRegScheduleList(ano, currentEnd);
		return list;
	}

	/**
	 * 예약 하기
	 */
	@Override
	public void doAppointmentAction(Appointment app) {
		rd.doAppointmentAction(app);
		
	}



}
