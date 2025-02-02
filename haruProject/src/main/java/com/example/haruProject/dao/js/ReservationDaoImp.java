package com.example.haruProject.dao.js;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pet;

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

}
