package com.example.haruProject.dao.hj;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.Product;

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

	@Override
	public Appointment getCommingRes(int memno) {
		Appointment commingRes= null;
		try {
			commingRes = session.selectOne("HJ_SelectCommingRes",memno);
			System.out.println("UserMainDao gerCommingRes commingRes-> "+commingRes);
		} catch (Exception e) {
			System.out.println("UserMainDao getCommingAppointment Error->"+e.getMessage());
		}
		return commingRes;
	}

	@Override
	public List<Product> getPopProductList() {
		List<Product> plist = new ArrayList<>();
		List <Product> purchaseCnt = new ArrayList<>();
		try {
			plist = session.selectList("HJ_PopularProductList");
		} catch (Exception e) {
			System.out.println("UserMainDao getPopProductList Error->"+e.getMessage());
		}
		return plist;
	}
}
