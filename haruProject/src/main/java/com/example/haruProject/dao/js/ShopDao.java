package com.example.haruProject.dao.js;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Product;
import com.example.haruProject.dto.SearchItem;

public interface ShopDao {

	int getTotalCnt(SearchItem si);
	List<Product> productList(int startRow, int endRow, SearchItem si);
	List<Map<String, Object>> getStatusList();
	List<Map<String, Object>> getCDList();

}
