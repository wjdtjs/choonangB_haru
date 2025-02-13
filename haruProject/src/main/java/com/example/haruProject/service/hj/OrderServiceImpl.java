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

	// 관리자 메인 페이지 > 픽업 대기 리스트
		@Override
		public List<Order> getMainOList() {
			System.out.println("service getMainOList start ,,,");
			
			List<Order> sList = od.getMainOList();
			System.out.println("service getMainOList sList ->"+sList);
			
			return sList;
		}

		// 관리자 메인 페이지 > 픽업 대기 수
		@Override
		public int getWaitPur() {
			System.out.println("service getWaitPur start ,,,");
			
			int wait_pur = od.getWaitPur();
			
			return wait_pur;
		}

		
		// scheduled > 픽업대기로 상태 변경 후 3일 지난 주문 리스트 불러오기
		@Override
		public List<Order> autoOrderCancel() {
			System.out.println("service autoOrderCancel start ,,,");
			
			List<Order> oList = od.autoOrderCancel();
			
			return oList;
		}

		@Override
		public String getOstatusContent(int ostatus_mcd) {
			String content = od.getOdtatusContent(ostatus_mcd);
			return content;
		}

}
