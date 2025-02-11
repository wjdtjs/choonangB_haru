package com.example.haruProject.dao.js;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Weight;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class PetDaoImp implements PetDao {
	
	private final SqlSession session;

	/**
	 * 동물 전체 수
	 */
	@Override
	public int getTotalCnt(SearchItem si) {
		int totalCnt = 0;
		try {
			totalCnt = session.selectOne("JS_SelectPetCount", si);
		} catch (Exception e) {
			log.error("getTotalCnt() query error -> ", e);
		}
		return totalCnt;
	}

	/**
	 * 동물 전체 리스트
	 */
	@Override
	public List<Pet> getPetList(Pagination pagination, SearchItem si) {
		List<Pet> petList = new ArrayList<>();
		Map<String, Object> pMap = new HashMap<>();
		pMap.put("startRow", pagination.getStartRow());
		pMap.put("endRow", pagination.getEndRow());
		pMap.put("search1", si.getSearch1());
		pMap.put("search2", si.getSearch2());
		
		try {
			petList = session.selectList("JS_SelectPetList", pMap);
		} catch (Exception e) {
			log.error("getTotalCnt() query error -> ", e);
		}
		return petList;
	}

	/**
	 * 동물 상세
	 */
	@Override
	public Pet getPetDetail(Pet pet) {
		Pet detail = new Pet();
		try {
			detail = session.selectOne("JS_SelectPetDetail", pet);
		} catch (Exception e) {
			log.error("getPetDetail() query error -> ", e);
		}
		return detail;
	}

	/**
	 * 몸무게 추가
	 */
	@Override
	public int addWeight(Weight weight) {
		int result = 0;
		try {
			result = session.insert("HR_insertWeight", weight);
		} catch (Exception e) {
			log.error("addWeight() query error -> ", e);
		}
		return result;
	}

}
