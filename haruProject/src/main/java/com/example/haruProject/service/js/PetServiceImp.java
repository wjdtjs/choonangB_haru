package com.example.haruProject.service.js;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.js.PetDao;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Weight;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class PetServiceImp implements PetService {
	
	private final PetDao pd;

	/**
	 * 동물 전체 수
	 */
	@Override
	public int getTotalCnt(SearchItem si) {
		int totalCnt = pd.getTotalCnt(si);
		return totalCnt;
	}

	/**
	 * 동물 전체 리스트
	 */
	@Override
	public List<Pet> getPetList(Pagination pagination, SearchItem si) {
		List<Pet> petList = new ArrayList<>();
		petList = pd.getPetList(pagination, si);
		
		return petList;
	}

	/**
	 * 동물 상세
	 */
	@Override
	public Pet getPetDetail(Pet pet) {
		Pet detail = new Pet();
		detail = pd.getPetDetail(pet);
		return detail;
	}

	/**
	 * 몸무게 추가
	 */
	@Override
	public int addWeight(Weight weight) {
		int result = pd.addWeight(weight);
		return result;
	}

	/**
	 * 동물 수정
	 */
	@Override
	public void updatePetInfo(Pet pet) {
		pd.updatePetInfo(pet);
		
	}

	/**
	 * 동물 추가
	 */
	@Override
	public void uploadPet(Pet pet) {
		pd.uploadPet(pet);
		
	}

}
