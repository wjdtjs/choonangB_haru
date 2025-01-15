package com.example.haruProject.service.hj;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.AdminDao;
import com.example.haruProject.dto.Admin;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
	
	private final AdminDao ad;

	@Override
	public List<Admin> adminListAll() {
		System.out.println("AdminServiceImpl adminListAll() Start...");
		List<Admin> adminList = ad.adminListAll();
		System.out.println("EmpServiceImpl deptSelect adminList.size()->"+adminList.size());
		return adminList;
	}

}
