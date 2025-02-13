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
import com.example.haruProject.dto.OrderProduct;

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
	public int getTotalCnt(SearchItem si) {
		int result = 0;
		try {
			result = session.selectOne("HJTotalCnt",si);
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
	public List<OrderProduct> getOrderProducts(int orderno) {
		List<OrderProduct> products = new ArrayList<>();
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
	

	@Override
	public List<Order> getMainOList() {
		System.out.println("dao getMainOList start ,,,");
		List<Order> sList = new ArrayList<>();
		
		try {
			sList = session.selectList("HR_getMainOList");			
			
			System.out.println("shopList.size()"+sList.size());
			
			for (int i=0 ; i < sList.size() ; i++) {
				int cnt = sList.get(i).getOrderCnt();
				if (cnt > 1) {
					cnt = cnt - 1;
					sList.get(i).setPname1(sList.get(i).getPname()+ "외 "+ cnt +"건");
					System.out.println("dao getMainOList sList ->"+sList);
				} else if (cnt == 1) {
					sList.get(i).setPname1(sList.get(i).getPname());
					System.out.println("dao getMainOList sList ->"+sList);
				}
			}
		} catch (Exception e) {
			System.out.println("ShopDao getMainOList error->"+e.getMessage());
		}
		return sList;
	}

	@Override
	public int getWaitPur() {
		System.out.println("dao getWaitPur start ,,,");
		
		int wait_pur = 0;
		
		try {
			wait_pur = session.selectOne("HR_getWaitPur");
		} catch (Exception e) {
			System.out.println("ShopDao getWaitPur error->"+e.getMessage());
		}
		
		return wait_pur;
	}

	@Override
	public List<Order> autoOrderCancel() {
		System.out.println("dao autoOrderCancel start ,,,");
		
		List<Order> oList = new ArrayList<>();
		
		try {
			oList = session.selectList("HR_autoOrderCancelList");
		} catch (Exception e) {
			System.out.println("ShopDao autoOrderCancel error->"+e.getMessage());
		}
		
		return oList;
	}

	@Override
	public String getOdtatusContent(int ostatus_mcd) {
		String content =  null;
		System.out.println("ostatus_mcd-> "+ostatus_mcd);
		try {
			content = session.selectOne("HJ_GetOstatusContent",ostatus_mcd);
			System.out.println("content-> "+content);
			
		} catch (Exception e) {
			System.out.println("OrderDap getOdtatusContent error->"+e.getMessage());
		}
		return content;
	}

}
