package com.example.haruProject.dao.hj;

import java.util.List;

import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProduct;

public interface OrderDao {

	List<Order> 		getShopList(int startRow, int endRow, SearchItem si);
	int					getTotalCnt(SearchItem si);
	Order 				getOrderInfo(int orderno);
	List<OrderProduct> 	getOrderProducts(int orderno);
	List<Common>		getOrderStatus();
	int					totalPrice(int orderno);
	int					updateOstatus(Order order);
	List<Order> 		getMainOList();
	int 				getWaitPur();
	List<Order> 		autoOrderCancel();
	String				getOdtatusContent(int ostatus_mcd);
}
