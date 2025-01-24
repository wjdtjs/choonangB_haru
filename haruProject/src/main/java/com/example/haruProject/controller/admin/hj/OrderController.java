package com.example.haruProject.controller.admin.hj;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProdct;
import com.example.haruProject.service.hj.OrderService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderController {
	private final OrderService os;
	
	/**
	 * 관리자페이지 상품판매관리 뷰
	 * @return
	 */
	@GetMapping("/admin/shop")
	public String shopView(	Model model,
							@RequestParam(value = "pageNum", required = false) String pageNum,
							@RequestParam(value = "blockSize", required = false, defaultValue = "10") String blockSize,
							@RequestParam(value = "type4", required = false, defaultValue = "0") int type4,
							@RequestParam(value = "type5", required = false, defaultValue = "0") int type5,
							@RequestParam(value = "search1", required = false) String search1
						  ) {
		
		System.out.println("ShopController shopView...");
		
		// 검색 필터
		SearchItem si = new SearchItem(type4,type5,search1);
		
		// 전체 주문건수
		int totalCnt = os.getTotalCnt();
		
		//페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		// 판매리스
		List<Order> shopList = os.getShopList(pagination.getStartRow(), pagination.getEndRow(), si);
		
		// 검색필터
		List<Common> ostatus = os.getOrderStatus();
		
		
		model.addAttribute("pagination",pagination);
		model.addAttribute("sales",shopList);
		model.addAttribute("search",si);
		model.addAttribute("ostatus",ostatus);
		
		
		return "admin/shop";
	}
	
	@GetMapping(value = "/admin/detailShop")
	public String getDetailSale(
									@RequestParam("orderno") int orderno,
									Model model
								) {
		System.out.println("SaleController getDetailShop");
		
		// 주문정보
		Order orderInfo = os.getOrderInfo(orderno);
		
		// 주문 상품 정보
		List<OrderProdct> products = os.getOrderProducts(orderno);
		//주문상태값 대중분류
		List<Common> ostatus = os.getOrderStatus();
		// 총결제금액
		int totalPrice = os.TotalPrice(orderno);

		model.addAttribute("sale",orderInfo);
		model.addAttribute("products",products);
		model.addAttribute("ostatus",ostatus);
		model.addAttribute("totalPrice",totalPrice);
		
		return "admin/detailShop";
	}
	
	@PostMapping(value = "/admin/updateOrder")
	public String updateOStatus (Order order1) {
		
		System.out.println("SaleController updateOStatus...");
		System.out.println("SaleController updateOStatus order1->"+order1);
		
		int result = os.updateOstatus(order1);
		
		return "redirect:shop";
	}
}
