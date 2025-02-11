package com.example.haruProject.service.hj;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.hj.OrderDao;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProduct;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService{
	
	private final OrderDao od;
	
	@Override
	public List<Order> getShopList(int startRow, int endRow, SearchItem si) {
		System.out.println("ShopService getShopList");
		List<Order> shopList = od.getShopList(startRow,endRow,si);
		
		return shopList;
	}

	@Override
	public int getTotalCnt(SearchItem si) {
		System.out.println("ShopService getTotalCnt");
		int totalCnt = od.getTotalCnt(si);
		return totalCnt;
	}

	@Override
	public Order getOrderInfo(int orderno) {
		System.out.println("ShopService getTotalCnt");
		
		Order orderInfo = od.getOrderInfo(orderno);
		return orderInfo;
	}

	@Override
	public List<OrderProduct> getOrderProducts(int orderno) {
		System.out.println("ShopService getOrderProducts...");
		List<OrderProduct> products = od.getOrderProducts(orderno);
		return products;
	}

	@Override
	public List<Common> getOrderStatus() {
		System.out.println("ShopService getOrderStatus...");
		List<Common> ostatus = od.getOrderStatus();
		return ostatus;
	}

	@Override
	public int TotalPrice(int orderno) {
		int result = od.totalPrice(orderno);
		return result;
	}

	@Override
	public int updateOstatus(Order order) {
		int result = od.updateOstatus(order);
		
		return result;
		
	}

	

}
