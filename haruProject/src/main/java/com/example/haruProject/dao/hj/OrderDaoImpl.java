package com.example.haruProject.dao.hj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProdct;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class OrderDaoImpl implements OrderDao{
	
	private final SqlSession session;
	
	@Override
	public List<Order> getShopList(int startRow, int endRow, SearchItem si) {
		System.out.println("ShopDao getShopList ...");
		List<Order> shopList = new ArrayList<>();
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("startRow", startRow);
		paramMap.put("endRow", endRow);
		paramMap.put("search", si);
		try {
			shopList = session.selectList("HJSelectShopList",paramMap);
			System.out.println("ShopDao getShopList shopList"+shopList);
			
			System.out.println("shopList.size()"+shopList.size());
			
			for (int i=0 ; i < shopList.size() ; i++) {
				int cnt = shopList.get(i).getOrderCnt();
				if (cnt > 1) {
					cnt = cnt - 1;
					shopList.get(i).setPname1(shopList.get(i).getPname()+ "외 "+ cnt +"건");
				} else if (cnt == 1) {
					shopList.get(i).setPname1(shopList.get(i).getPname());
				}
			}
			
			/*
			 * int cnt = shopList.getOrderCnt(); System.out.println("cnt->"+cnt); if (cnt >
			 * 1) { cnt = cnt - 1; shopList.setPname1(shopList.g()+"외 "+cnt+"건"); } else if
			 * (cnt == 1){ shopList.setPname1(shopList.getPname()); }
			 */
		} catch (Exception e) {
			System.out.println("ShopDao getShopList error->"+e.getMessage());
			
		}
		return shopList;
	}

	@Override
	public int getTotalCnt() {
		int result = 0;
		try {
			result = session.selectOne("HJTotalCnt");
			System.out.println("ShopDao getShopList result -> "+result);
		} catch (Exception e) {
			System.out.println("ShopDao getTotalCnt error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public Order getOrderInfo(int orderno) {
		Order result = null;
		try {
			result = session.selectOne("HJGetOrderDetail",orderno);
		} catch (Exception e) {
			System.out.println("ShopDao getTotalCnt error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public List<OrderProdct> getOrderProducts(int orderno) {
		List<OrderProdct> products = new ArrayList<>();
		System.out.println("OrderDao getOrderProducts orderno"+orderno);

		try {
			products = session.selectList("HJSelectOrderProducts",orderno);
		} catch (Exception e) {
			System.out.println("ShopDao getOrderProducts error->"+e.getMessage());
		}

		return products;
	}

	@Override
	public List<Common> getOrderStatus() {
		List<Common> ostatus = new ArrayList<>();
		try {
			ostatus = session.selectList("HJOrderStatus");
		} catch (Exception e) {
			System.out.println("ShopDao getOrderStatus error->"+e.getMessage());
		}
		return ostatus;
	}

	@Override
	public int totalPrice(int orderno) {
		int result = 0;
		try {
			result = session.selectOne("HJTotalprice",orderno);
		} catch (Exception e) {
			System.out.println("ShopDao totalPrice error->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int updateOstatus(Order order) {
		int result = 0;
		try {
			result = session.update("HJUpateOstatus",order);
		} catch (Exception e) {
			System.out.println("ShopDao updateOstatus error->"+e.getMessage());
		}
		return result;
	}

}
