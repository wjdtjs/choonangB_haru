package com.example.haruProject.service.js;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.js.ReservationDao;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pet;

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

}
