package com.example.haruProject.service.hj;

import java.util.List;

import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Shop;

public interface ShopService {

	List<Shop> getShopList(int startRow, int endRow, SearchItem si);
	int		getTotalCnt();

}
