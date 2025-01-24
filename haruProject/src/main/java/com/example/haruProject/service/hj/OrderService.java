package com.example.haruProject.service.hj;

import java.util.List;

import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProdct;

public interface OrderService {

	List<Order> 		getShopList(int startRow, int endRow, SearchItem si);
	int					getTotalCnt();
	Order				getOrderInfo(int orderno);
	List<OrderProdct> 	getOrderProducts(int orderno);
	List<Common>		getOrderStatus();
	int					TotalPrice(int orderno);
	int					updateOstatus(Order order);
	

}
