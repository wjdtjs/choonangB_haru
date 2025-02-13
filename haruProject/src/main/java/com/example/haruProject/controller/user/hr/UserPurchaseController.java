package com.example.haruProject.controller.user.hr;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.dto.ApproveResponse;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.Product;
import com.example.haruProject.dto.Purchase;
import com.example.haruProject.dto.ReadyResponse;
import com.example.haruProject.dto.ShoppingCart;
import com.example.haruProject.service.hr.KakaoPayService;
import com.example.haruProject.service.hr.UserPurchaseService;
import com.example.haruProject.service.js.ShopService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class UserPurchaseController {
	private final UserPurchaseService ps;
	
	/*
	 * 장바구니 뷰
	 * memno
	 */
	@GetMapping("/user/shoppingCart")
	public String shoppingCartView(HttpServletRequest request, Model model) {
		System.out.println("UserPurchaseController shoppingCartView() start ,,,");
		
		int memno = SessionUtil.getNo(request);
		
		System.out.println("UserPurchaseController shoppingCartView() memno ->"+memno);

		List<ShoppingCart> sList = ps.getShoppingCartList(memno);
		
		model.addAttribute("sList", sList);
		
		return "user/shoppingCart";
	}
	
	// 장바구니 수량에 따른 squantity DB update
	@ResponseBody
	@RequestMapping("/api/updateSquantity")
	public void updateSquantity(@RequestParam(value = "pno", required = true) int pno,
							@RequestParam(value = "squantity", required = true) int squantity,
							HttpServletRequest request)
	{
		System.out.println("UserPurchaseController updateSquantity() start ,,,");
		System.out.println("UserPurchaseController updateSquantity() pno ->"+pno);
		System.out.println("UserPurchaseController updateSquantity() squantity ->"+squantity);
		
		int memno = SessionUtil.getNo(request);
		
		ps.updateSquantity(pno, squantity, memno);
		
	}
	
	// 장바구니에서 삭제
	@RequestMapping("/user/deleteSP")
	public String deleteShoppingProduct(@RequestParam(value = "pno", required = true) int pno,
										HttpServletRequest request) {
		System.out.println("UserPurchaseController deleteShoppingProduct() start ,,,");
		System.out.println("UserPurchaseController deleteShoppingProduct() pno ->"+pno);
		
		int memno = SessionUtil.getNo(request);
		
		ps.deleteSP(memno, pno);
		
		return "redirect:/user/shoppingCart";
	}

	
	/*
	 * 주문하기 뷰 (장바구니)
	 * memno
	 */
	@GetMapping("/user/purchaseView")
	public String puchaseView(@RequestParam(value = "pnoList", required = true) String pnoListStr,
								HttpServletRequest request,
								Model model) {
		System.out.println("UserPurchaseController purchaseView() start ,,,");
		System.out.println("UserPurchaseController purchaseView() pnoListStr ->"+pnoListStr);
		
		// 받은 pno 문자열 pnoList로 변환
		List<Integer> pnoList = Arrays.stream(pnoListStr.split(","))
						                .map(Integer::parseInt)
						                .collect(Collectors.toList());
		
		int memno = SessionUtil.getNo(request);
		
		List<ShoppingCart> sList = ps.getorderList(memno, pnoList);
		
		int totalSquantity = sList.stream().mapToInt(p -> p.getSquantity()).sum();
		int totalPrice = sList.stream().mapToInt(p -> p.getSquantity()*p.getPprice()).sum();
		
		// 주문상품에 대한 정보 전달
		// pbrand, pname, pprice, squantity
		model.addAttribute("sList", sList);
		model.addAttribute("totalSquantity", totalSquantity);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("direct_purchase", 0);
		
		return "user/purchase";
	}
	
	/*
	 * 주문하기 뷰 (상품상세)
	 * memno
	 */	
	private final ShopService ss;
	@GetMapping("/user/direct_purchase")
	public String direct_purchase(@RequestParam(value = "pno", required = true) int pno,
								@RequestParam(value = "squantity", required = true) int squantity,
								HttpServletRequest request,
								Model model) {
		System.out.println("UserPurchaseController direct_purchase() start ,,,");
		System.out.println("UserPurchaseController direct_purchase() pno ->"+pno);
		System.out.println("UserPurchaseController direct_purchase() squantity ->"+squantity);

		Product p = ss.getProductDetail(Integer.toString(pno));
		System.out.println("product -> "+p);
		
		int totalSquantity = squantity;
		int totalPrice = p.getPprice() * totalSquantity;
		
		// 주문상품에 대한 정보 전달
		// pbrand, pname, pprice, squantity
		model.addAttribute("p", p);
		model.addAttribute("totalSquantity", totalSquantity);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("direct_purchase", 1);
		
		return "user/purchase";
	}
	
	
	
	
	/*
	 * 주문하기
	 * 
	 * 매장 결제
	 */
	@ResponseBody
	@RequestMapping("/api/user/s-purchase")
	public Map<String, Object> storePurchase(@RequestBody List<Purchase> pList,
												HttpServletRequest request,
												Model model)
	{
		System.out.println("UserPurchaseController storePurchase() start ,,, ");
//		for (Purchase purchase : pList) {
//	        System.out.println("상품 번호: " + purchase.getPno());
//	        System.out.println("상품 이름: " + purchase.getPname());
//	        System.out.println("구매 수량: " + purchase.getSquantity());
//	        System.out.println("상품 가격: " + purchase.getPprice());
//	        System.out.println("결제 방법 코드: " + purchase.getOpayment_mcd());
//	        System.out.println("총 결제 금액: " + purchase.getOtotal_price());
//	    }
		
		int memno = SessionUtil.getNo(request);
		int opayment_mcd = pList.get(0).getOpayment_mcd();
		int ototal_price = pList.get(0).getOtotal_price();
		int dp = pList.get(0).getDp();
		System.out.println("pList ->"+pList);
		System.out.println("dp ->"+dp);

//		System.out.println("memno: "+memno);
//		System.out.println("opayment_mcd: "+opayment_mcd);
//		System.out.println("ototal_price: "+ototal_price);
		int orderno = 0;
		
		orderno = ps.skPurchase(pList, memno, opayment_mcd, ototal_price, dp);
		System.out.println("purchase controller orderno ->"+orderno);
		
		Map<String, Object> response = new HashMap<>();
		response.put("orderno", orderno);
		response.put("redirectUrl", "/user/purchaseResult?orderno="+orderno);
		
		return response;
	}
	
	
	/*
	 * 주문완료 뷰
	 * orderno
	 */
	@GetMapping("/user/purchaseResult")
	public String purchaseResultView(@RequestParam(value = "orderno", required = true) int orderno,
									 Model model) {
		System.out.println("UserPurchaseController purchaseResultView() start ,,,");
		System.out.println("UserPurchaseController purchaseResultView() orderno ->"+orderno);
		
		model.addAttribute("orderno", orderno);
		// 카카오페이 결제하고 나서 결제할 때 tid 안 뜨게 세션에 있는 tid를 null로 설정
		SessionUtil.addAttribute("tid", null);
		
		return "user/purchaseResult";
	}
}
