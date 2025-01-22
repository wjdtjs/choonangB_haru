package com.example.haruProject.dao.hj;

import java.util.List;

import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Shop;

public interface ShopDao {

	List<Shop> 	getShopList(int startRow, int endRow, SearchItem si);
	int			getTotalCnt();

}
