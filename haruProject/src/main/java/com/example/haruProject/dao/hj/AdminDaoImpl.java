package com.example.haruProject.dao.hj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AdminDaoImpl implements AdminDao {
	private final SqlSession session;

	@Override
	public int getTotalCnt(SearchItem si) {
		int totalCnt = 0;
		System.out.println("AdminDao getTotalCnt Start...");
		
		try {
			totalCnt = session.selectOne("HJSelectTotalCnt",si);
			System.out.println("AdminDao getTotalCnt totalCnt"+totalCnt);
		} catch (Exception e) {
			System.out.println("AdminDaoImpl getTotalCnt error->"+e.getMessage());
		}
		
		return totalCnt;
	}
	
	/**
	 * 상품 목록 가져오기 (페이지네이션)
	 * @param startRow	첫 게시글
	 * @param endRow	마지막 게시글 
	 * @param si		검색필터
	 * @return
	 */
	@Override
	public List<Admin> adminList(int startRow, int endRow, SearchItem si) {
		System.out.println("AdminDaoImpl adminList Start,,,");
		List<Admin> list = new ArrayList<>();
		Map<String, Object> parameterMap = new HashMap<>();
		parameterMap.put("startRow", startRow);
		parameterMap.put("endRow", endRow);
		parameterMap.put("search", si);
		
		try {
			list = session.selectList("HJSelectAdminList",parameterMap);
		} catch (Exception e) {
			System.out.println("AdminDaoImpl getTotalCnt error->"+e.getMessage());
		}
		return list;
	}

	@Override
	public int adminAdd(Admin admin) {
		System.out.println("AdminDaoImpl adminAdd Start,,,");
		int addAdmin = 0;
		System.out.println("admin ->"+admin);
		try {
			addAdmin = session.insert("HJInsertAdmin", admin);
		} catch (Exception e) {
			System.out.println("AdminDaoImpl getTotalCnt error->"+e.getMessage());
			// TODO: handle exception
		}
		return addAdmin;
	}

	@Override
	public List<Admin> adminAlevelMcd() {
		System.out.println("AdminDaoImpl adminAlevelMcd Start,,,");
		List<Admin> alevelMcd = null;
		try {
			alevelMcd = session.selectList("HJSelectAdminAlevel");
		} catch (Exception e) {
			System.out.println("AdminDaoImpl adminAlevelMcd error->"+e.getMessage());
		}
		return alevelMcd;
	}

}
