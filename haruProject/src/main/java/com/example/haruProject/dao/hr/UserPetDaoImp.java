package com.example.haruProject.dao.hr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Weight;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class UserPetDaoImp implements UserPetDao {
	private final SqlSession session;
	
	// 마이페이지 > 동물 카드 정보 불러오기
	@Override
	public List<Pet> getPetList(int memno) {
		System.out.println("UserPetDaoImp getPetList() start,,,");
		System.out.println("UserPetDaoImp getPetList() memno ->"+memno);
		
		List<Pet> pList = new ArrayList<>();
		
		try {
			pList = session.selectList("HR_getPetList",1);
			System.out.println("UserPetDaoImp getPetList() pList ->"+pList);
		} catch (Exception e) {
			log.error("getPetList() error ->", e);
		}
		
		return pList;
	}

	// 동물 정보 추가 > 종 대분류 불러오기
	@Override
	public List<Pet> getSpeciesBcd() {
		System.out.println("UserPetDaoImp getSpeciesBcd() start ,,,");
		
		List<Pet> pList = new ArrayList<>();
		
		try {
			pList = session.selectList("HR_getPetSpeciesBcd");
		} catch (Exception e) {
			log.error("getSpeciesBcd() error ->", e);
		}
		
		return pList;
	}
	// 대분류 값에 따른 종 중분류 불러오기
	@Override
	public List<Pet> getSpeciesMcd(int bcd) {
		System.out.println("UserPetDaoImp getSpeciesMcd start ,,,");
		System.out.println("UserPetDaoImp getSpeciesMcd bcd ->"+bcd);
		
		List<Pet> pList = new ArrayList<>();
		
		try {
			pList = session.selectList("HR_getPetSpeciesMcd", bcd);
		} catch (Exception e) {
			log.error("getSpeciesMcd() error ->", e);
		}
		
		return pList;
	}

	// 동물페이지 > 동물 정보 불러오기
	@Override
	public Pet getPetDetail(int petno) {
		System.out.println("UserPetDaoImp getPetDetail start ,,,");
		System.out.println("UserPetDaoImp getPetDetail petno ->"+petno);
		
		Pet pet = new Pet();
		
		try {
			pet = session.selectOne("HR_getPetDetail", petno);
			System.out.println("pet ->"+pet);
		} catch (Exception e) {
			log.error("getPetDetail() error ->", e);
		}
		
		return pet;
	}

	// 동물 페이지 > 동물 몸무게 불러오기
	@Override
	public List<Weight> getPetWeightList(int petno) {
		System.out.println("UserPetDaoImp getPetWeightList start ,,,");
		System.out.println("UserPetDaoImp getPetWeightList petno ->"+petno);
		
		List<Weight> wList = new ArrayList<>();
		
		try {
			wList = session.selectList("HR_getPetWeightList", petno);
		} catch (Exception e) {
			log.error("getPetWeightList() error ->", e);
		}
		
		return wList;
	}
	// 몸무게 > 동물 몸무게 불러오기 (페이지네이션)
	@Override
	public List<Weight> getPetWeightList(int petno, int startRow, int endRow) {
		List<Weight> wList = new ArrayList<>();
		
		Map<String, Object> wMap = new HashMap<>();
		wMap.put("petno", petno);
		wMap.put("startRow", startRow);
		wMap.put("endRow", endRow);
		
		try {
			wList = session.selectList("HR_getPetWeightList_pn", wMap);
		} catch (Exception e) {
			log.error("getPetWeightList() error ->", e);
		}
		
		return wList;
	}
	// 몸무게 수 불러오기
	@Override
	public int getWeightCnt(int petno) {
		int totalCnt = 0;
		try {
			totalCnt = session.selectOne("HR_selectWeightCnt", petno);
		} catch (Exception e) {
			log.error("getWeightCnt() query error -> ", e);
		}
		
		return totalCnt;
	}


	// 동물페이지 > 예약 정보 불러오기
	@Override
	public List<Appointment> getPAppointmentList(int petno) {
		System.out.println("UserPetDaoImp getPAppointmentList start ,,,");
		System.out.println("UserPetDaoImp getPAppointmentList petno ->"+petno);
		
		List<Appointment> aList = new ArrayList<>();
		
		try {
			aList = session.selectList("HR_getPAppointmentList", petno);
		} catch (Exception e) {
			log.error("getPAppointmentList() error ->", e);
		}
		
		return aList;
	}

	// 동물 정보 삭제하기
	@Override
	public int deletePet(int petno) {
		System.out.println("UserPetDaoImp deletePet start ,,,");
		System.out.println("UserPetDaoImp deletePet petno ->"+petno);
		
		int result = 0;
		
		try {
			result = session.update("HR_deletePet", petno);
		} catch (Exception e) {
			log.error("deletePet() error ->", e);
		}
		
		return result;
	}

	// 동물 추가
	@Override
	public void addPet(Pet pet) {
		System.out.println("UserPetDaoImp deletePet start ,,,");
		System.out.println("UserPetDaoImp deletePet pet ->"+pet);
		
		try {
			session.insert("HR_AddPet", pet);			// pet 테이블에 데이터 추가
			session.insert("HR_AddPetWeight", pet);		// petweight 따로 weight 테이블에 추가
		} catch (Exception e) {
			log.error("addPet() error ->", e);
		}
	}

	// 동물 수정
	@Override
	public void updatePet(Pet pet, boolean img_change) {
		System.out.println("UserPetDaoImp updatePet start ,,,");
		System.out.println("UserPetDaoImp updatePet pet ->"+pet);
		System.out.println("UserPetDaoImp updatePet img_change ->"+img_change);
		
		Map<String, Object> uMap = new HashMap<>();
		uMap.put("pet", pet);
		uMap.put("ic", img_change);
		
		try {
			session.update("HR_updatePet", uMap);
			session.insert("HR_UpdatePetWeight", pet);
		} catch (Exception e) {
			log.error("addPet() error ->", e);
		}

	}

	// 동물 몸무게 수정(추가)
	@Override
	public void updateWeight(Weight weight) {
		System.out.println("UserPetDaoImp updateWeight start ,,,");
		System.out.println("UserPetDaoImp updateWeight weight ->"+weight);
		
		try {
			session.insert("HR_insertWeight", weight);
			session.update("HR_updateWeight", weight);
		} catch (Exception e) {
			log.error("addPet() error ->", e);
		}
	}

	// 몸무게 totalCnt
	@Override
	public int getWeightCnt(int petno, int startRow, int endRow) {
		int totalCnt = 0;
		
		Map<String, Object> wMap = new HashMap<>();
		wMap.put("petno", petno);
		wMap.put("startRow", startRow);
		wMap.put("endRow", endRow);
		
		try {
			totalCnt = session.selectOne("HR_selectWeightCnt_pn", wMap);
		} catch (Exception e) {
			log.error("getWeightCnt() error ->", e);
		}
		return totalCnt;
	}



}
