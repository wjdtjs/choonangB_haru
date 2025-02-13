package com.example.haruProject.controller.user.js;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Product;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.js.ShopService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class UserShopController {
	
	private final ShopService ss;
	
	/**
	 * 상품 리스트
	 * @param pageNum
	 * @param blockSize
	 * @param bcd
	 * @param mcd
	 * @param product
	 * @param model
	 * @return
	 */
	@GetMapping("/user/shop")
	public String shopView(@RequestParam(value = "pageNum", required = true, defaultValue="1") String pageNum,
							@RequestParam(value = "blockSize", required = false, defaultValue="10") int blockSize,
							@RequestParam(value = "bcd", required = true, defaultValue="410") int bcd,
							@RequestParam(value = "mcd", required = true, defaultValue="999") int mcd,
							HttpServletRequest request,
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
		int memno = SessionUtil.getNo(request);
		int cart_count = ss.getCartCount(memno);
		
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
	
	
	/**
	 * 상품 상세
	 * @param product
	 * @param model
	 * @return
	 */
	@GetMapping("/user/details-product")
	public String detailsProductView(@RequestParam(value = "pageNum", required = true, defaultValue="1") String pageNum,
									@RequestParam(value = "blockSize", required = false, defaultValue="10") int blockSize,
									HttpServletRequest request,
									Product product, Model model) 
	{
		log.info("detailsProductView() start..");
		
		//쇼핑카트 담아둔 상품 수
		int memno = SessionUtil.getNo(request);
		int cart_count = ss.getCartCount(memno); 
		
		int pno = product.getPno(); //상품번호
		
		//상품 후기
		List<Board> reviews = new ArrayList<>();
		
		int totalCnt = ss.getProductReviewTotCnt(pno);
		Pagination pagination = new Pagination(totalCnt, pageNum, blockSize);
		
		reviews = ss.productReviewList(pagination.getStartRow(), pagination.getEndRow(), pno);
		
		
		//상품 상세
		product = ss.getProductDetail(Integer.toString(pno));
		
		//프론트에서 노출될 필요 없는 정보들 초기화..(쿼리재사용해서..)
		product.setPstatus_mcd(0);
		product.setAno(0);
		product.setUpdate_date(null);
		product.setReg_date(null);
		
		model.addAttribute("cart_count", cart_count);
		model.addAttribute("product", product);
		model.addAttribute("reivew", reviews);
		model.addAttribute("pagination", pagination);
		
		if (model.containsAttribute("result")) {
			int result = 1;
	        System.out.println("Flash Attribute: " + model.getAttribute("result"));
	        if(model.getAttribute("result").equals(0)) {
	        	result = 0;	        	
	        }
	        model.addAttribute("result", result);
		} 
		
		return "user/detailsProduct";
	}
	
	
	/**
	 * 상품 리뷰 전체 보기
	 * @param pageNum
	 * @param blockSize
	 * @param board
	 * @param model
	 * @return
	 */
	@GetMapping("/user/shop-reviews")
	public String getWholeProductReviews(@RequestParam(value = "pageNum", required = true, defaultValue="1") String pageNum,
										@RequestParam(value = "blockSize", required = false, defaultValue="10") int blockSize,
										Product product, Model model) 
	{
		log.info("getWholeProductReviews() start..");
		
		int pno = product.getPno(); //상품번호

		List<Board> reviews = new ArrayList<>();
		
		int totalCnt = ss.getProductReviewTotCnt(pno);
		Pagination pagination = new Pagination(totalCnt, pageNum, blockSize);
		
		reviews = ss.productReviewList(pagination.getStartRow(), pagination.getEndRow(), pno);
		
		System.out.println("==== "+ reviews);
		
		model.addAttribute("pno", pno);
		model.addAttribute("pagination", pagination);
		model.addAttribute("review", reviews);
		
		return "user/productReview";
	}
	
	/**
	 * 장바구니에 추가
	 * @param product
	 * @return
	 */
	@PostMapping("/user/updateCart")
	public String updateShoppingCart(Product product, HttpServletRequest request
									, RedirectAttributes attr
									) {
		log.info("updateShoppingCart() start..");
		
		int memno = SessionUtil.getNo(request);
		
		System.out.println("updateShoppingCart() product -> "+product);
		
		int result = ss.updateShoppingCart(product, memno);
		System.out.println("장바구니 결과 : "+result);
		
		attr.addFlashAttribute("result", result); //상품상세에 장바구니 추가 결과 전달
		attr.addAttribute("pno", product.getPno());
		
		return "redirect:details-product";
	}
	
}
