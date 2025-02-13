package com.example.haruProject.service.hj;

import java.util.List;

import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProduct;

public interface OrderService {

	List<Order> 		getShopList(int startRow, int endRow, SearchItem si);
	int					getTotalCnt(SearchItem si);
	Order				getOrderInfo(int orderno);
	List<OrderProduct> 	getOrderProducts(int orderno);
	List<Common>		getOrderStatus();
	int					TotalPrice(int orderno);
	int					updateOstatus(Order order);
	List<Order> 		getMainOList();
	int 				getWaitPur();
	List<Order> 		autoOrderCancel();
	String				getOstatusContent(int ostatus_mcd);

}
