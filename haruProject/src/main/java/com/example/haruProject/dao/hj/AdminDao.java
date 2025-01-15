package com.example.haruProject.dao.hj;

import java.util.List;

import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.SearchItem;

public interface AdminDao {

	int getTotalCnt(SearchItem si);
	List<Admin> adminList(int startRow, int endRow, SearchItem si);

	

}
