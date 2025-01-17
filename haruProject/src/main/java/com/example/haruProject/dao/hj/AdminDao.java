package com.example.haruProject.dao.hj;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.SearchItem;

public interface AdminDao {

	int 			getTotalCnt(SearchItem si);
	List<Admin>		adminList(int startRow, int endRow, SearchItem si);
	int				adminAdd(Admin admin);
	List<Admin> 	adminAlevelMcd();
	Admin			getAdminDetail(int ano);
	List<Map<String, Object>>		adminCommon();
	int				updateAdmin(Admin admin);

	

}
