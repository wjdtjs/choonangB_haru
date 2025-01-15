package com.example.haruProject.service.hj;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.AdminDao;
import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
	
	private final AdminDao ad;

	@Override
	public int getTotalCnt(SearchItem si) {
		System.out.println("AdminService getTotalCnt Start...");
		int totalCnt = ad.getTotalCnt(si);
		return totalCnt;
	}

	@Override
	public List<Admin> adminList(int startRow, int endRow, SearchItem si) {
		System.out.println("adminService adminList Start...");
		
		List<Admin> aList = new ArrayList<>();
		
		aList = ad.adminList(startRow, endRow, si);
		System.out.println("adminService adminList aList->"+aList);
		return aList;
	}

	@Override
	public int adminAdd(Admin admin) {
		System.out.println("AdminService adminAdd Start...");
		
		int addAdmin = ad.adminAdd(admin);
		System.out.println("AdminService admimAdd addAdmin->"+addAdmin);
		
		return addAdmin;
	}

	@Override
	public List<Admin> adminLevelMcd() {
		System.out.println("AdminService adminLevelMcd Start...");
		
		List<Admin> alevelList = ad.adminAlevelMcd();

		
		return alevelList;
	}

}
