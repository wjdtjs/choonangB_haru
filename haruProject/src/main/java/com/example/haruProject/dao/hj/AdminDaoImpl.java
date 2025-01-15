package com.example.haruProject.dao.hj;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Admin;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AdminDaoImpl implements AdminDao {
	private final SqlSession session;

	@Override
	public List<Admin> adminListAll() {
		List<Admin> adminList = null;
		System.out.println("AdminDaoImpl adminListAll() Start...");
		try {
			adminList = session.selectList("hjAdminList");
		} catch (Exception e) {
			System.out.println("AdminDaoImpl adminListAll() Exception->"+e.getMessage());
		}
		return adminList;
	}
	
}
