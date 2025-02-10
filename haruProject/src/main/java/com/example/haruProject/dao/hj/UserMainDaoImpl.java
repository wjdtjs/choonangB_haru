package com.example.haruProject.dao.hj;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.Pet;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserMainDaoImpl implements UserMainDao {
	private final SqlSession session;

	@Override
	public List<Notice> getNoticeList() {
		List<Notice> notices = new ArrayList<>();
		
		try {
			notices = session.selectList("JS_SelectNoticeTop");
		} catch (Exception e) {
			System.out.println("UserMainDao getNoticeList e.getMessage()" + e.getMessage());
		}
		return notices;
	}

	@Override
	public List<Pet> getPetList(int memno) {
		List<Pet> pets = new ArrayList<>();
		try {
			pets = session.selectList("HR_getPetList",memno);
		} catch (Exception e) {
			System.out.println("UserMainDao getPetList e.getMessage()" + e.getMessage());
		}
		return pets;
	}
}
