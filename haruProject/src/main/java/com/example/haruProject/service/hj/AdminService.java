package com.example.haruProject.service.hj;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.SearchItem;

public interface AdminService {

	int			getTotalCnt(SearchItem si);
	List<Admin> adminList(int startRow, int endRow, SearchItem si);
	int			adminAdd(Admin admin);
	List<Admin> adminLevelMcd();
	Admin		getAdminDetail(int ano);
	int			updateAdmin(Admin admin);
	List<Map<String, Object>> acommonList();

}
