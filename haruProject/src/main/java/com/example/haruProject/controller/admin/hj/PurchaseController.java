package com.example.haruProject.controller.admin.hj;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.dto.Shop;
import com.example.haruProject.service.hj.ShopService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class PurchaseController {
	private final ShopService ss;
	
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
		int totalCnt = ss.getTotalCnt();
		
		//페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		List<Shop> shopList = ss.getShopList(pagination.getStartRow(), pagination.getEndRow(), si);
		model.addAttribute("sales",shopList);
		model.addAttribute("search",si);
		
		
		return "admin/shop";
	}
}
