package com.example.haruProject.service.js;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Product;
import com.example.haruProject.dto.SearchItem;

public interface ShopService {

	List<Product> productList(int startRow, int endRow, SearchItem si);
	int getTotalCnt(SearchItem si);
	List<Map<String, Object>> getStatusList();
	List<Map<String, Object>> getBCDList();
	List<Map<String, Object>> getMCDList(int bcd);
	void uploadProduct(Product pd);
	Product getProductDetail(String pno);
	void updateProduct(Product pd);
	
	
}
