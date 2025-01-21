package com.example.haruProject.controller.user.js;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Product;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.js.ShopService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class UserShopController {
	
	private final ShopService ss;
	
	@GetMapping("/user/shop")
	public String shopView(@RequestParam(value = "pageNum", required = true, defaultValue="1") String pageNum,
							@RequestParam(value = "blockSize", required = false, defaultValue="10") int blockSize,
							@RequestParam(value = "bcd", required = true, defaultValue="410") int bcd,
							@RequestParam(value = "mcd", required = true, defaultValue="999") int mcd,
							Product product, Model model) 
	{
		log.info("shopView() start..");
		
		//상품 대분류
		List<Map<String, Object>> bcdList = new ArrayList<>();
		//상품 중분류
		List<Map<String, Object>> mcdList = new ArrayList<>();
		bcdList = ss.getBCDList();
		mcdList = ss.getMCDList(bcd);
		
		//쇼핑카트 담아둔 상품 수
		int cart_count = ss.getCartCount(1); //TODO: MEMNO 변경해주기
		
		//노출 상품만
		SearchItem si = new SearchItem(bcd, mcd, 100);
		
		//공지사항 전체 수 (필터 적용)
		int totalCnt = ss.getCDProductCnt(si);
		//페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, blockSize);
		System.out.println(pagination);
		
		List<Product> pList = new ArrayList<>();
		pList = ss.cdProductList(pagination.getStartRow(), pagination.getEndRow(), si);
		
//		System.out.println("cBcd "+bcd);
//		System.out.println("bcdList "+bcdList);
		System.out.println(pList);
		
		model.addAttribute("cBcd", bcd);
		model.addAttribute("cMcd", mcd);
		model.addAttribute("bcdList", bcdList);
		model.addAttribute("mcdList", mcdList);
		model.addAttribute("cart_count", cart_count);
		model.addAttribute("pList", pList);
		model.addAttribute("pagination", pagination);
		
		return "user/shop";
	}
	
}
