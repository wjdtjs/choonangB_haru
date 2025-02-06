package com.example.haruProject.service.hr;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hr.UserPetDao;
import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Weight;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserPetServiceImp implements UserPetService {
	private final UserPetDao pd;

	// 마이페이지 > 동물 카드에 정보 불러오기
	@Override
	public List<Pet> getPetList(int memno) {
		System.out.println("UserPetServiceImp getPetList() start ,,,");
		System.out.println("UserPetServiceImp getPetList() memno ->"+memno);
		
		List<Pet> pList = pd.getPetList(memno);

		return pList;
	}

	// 동물 정보 추가 > 종 대분류 불러오기
	@Override
	public List<Pet> getSpeciesBcd() {
		System.out.println("UserPetServiceImp getSpeciesBcd() start ,,,");
		
		List<Pet> pList = pd.getSpeciesBcd();
		
		return pList;
	}
	// 대분류 값에 따른 종 중분류 불러오기
	@Override
	public List<Pet> getSpeciesMcd(int bcd) {
		System.out.println("UserPetServiceImp getSpeciesMcd() start ,,,");
		System.out.println("UserPetServiceImp getSpeciesMcd() bcd ->"+bcd);
		
		List<Pet> pList = pd.getSpeciesMcd(bcd);
		
		return pList;
	}

	// 동물페이지 > 마이페이지에서 선택된 동물에 대한 동물 정보 불러오기
	@Override
	public Pet getPetDetail(int petno) {
		System.out.println("UserPetServiceImp getPetDetail() start ,,,");
		System.out.println("UserPetServiceImp getPetDetail() petno ->"+petno);
		
		Pet pet = new Pet();
		
		pet = pd.getPetDetail(petno);
		
		return pet;
	}

	// 동물페이지 > 몸무게 불러오기 
	@Override
	public List<Weight> getPetWeightList(int petno) {
		System.out.println("UserPetServiceImp getPetWeightList() start ,,,");
		System.out.println("UserPetServiceImp getPetWeightList() petno ->"+petno);
		
		List<Weight> wList = pd.getPetWeightList(petno);
		
		return wList;
	}
	

	// 동물페이지 > 예약정보 불러오기
	@Override
	public List<Appointment> getPAppointmentList(int petno) {
		System.out.println("UserPetServiceImp getPAppointmentList() start ,,,");
		System.out.println("UserPetServiceImp getPAppointmentList() petno ->"+petno);
		
		List<Appointment> aList = pd.getPAppointmentList(petno);
		
		return aList;
	}

	// 동물 정보 삭제하기
	@Override
	public int deletePet(int petno) {
		System.out.println("UserPetServiceImp deletePet() start ,,,");
		System.out.println("UserPetServiceImp deletePet() petno ->"+petno);
		
		int result = pd.deletePet(petno);
		
		return result;
	}

	// 동물 추가하기
	@Override
	public void addPet(Pet pet) {
		System.out.println("UserPetServiceImp deletePet() start ,,,");
		System.out.println("UserPetServiceImp deletePet() pet ->"+pet);
		
		pd.addPet(pet);
	}

	// 동물 수정하기
	@Override
	public void updatePet(Pet pet, boolean img_change) {
		System.out.println("UserPetServiceImp addPet() start ,,,");
		pd.updatePet(pet, img_change);
	}

	// 동물 몸무게 수정(weight DB에 추가)
	@Override
	public void updateWeight(Weight weight) {
		System.out.println("UserPetServiceImp updateWeight() start ,,,");
		System.out.println("UserPetServiceImp updateWeight() weight ->"+weight);
		
		pd.updateWeight(weight);
	}

	// 몸무게 > 전체 몸무게 리스트 수
	@Override
	public int getWeightCnt(int petno) {
		int totalCnt = pd.getWeightCnt(petno);
		return totalCnt;
	}

	// 몸무게 > 몸무게 불러오기 (페이지네이션)
	@Override
	public List<Weight> getPetWeightList(int petno, int startRow, int endRow) {
		System.out.println("UserPetServiceImp getPetWeightList() start ,,,");
		System.out.println("UserPetServiceImp getPetWeightList() petno ->"+petno);
		
		List<Weight> wList = pd.getPetWeightList(petno, startRow, endRow);
		
		return wList;
	}
	
	

}
