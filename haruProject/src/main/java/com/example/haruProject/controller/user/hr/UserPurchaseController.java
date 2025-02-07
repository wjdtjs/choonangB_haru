package com.example.haruProject.controller.user.hr;

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

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.dto.ApproveResponse;
import com.example.haruProject.dto.Purchase;
import com.example.haruProject.dto.ReadyResponse;
import com.example.haruProject.dto.ShoppingCart;
import com.example.haruProject.service.hr.KakaoPayService;
import com.example.haruProject.service.hr.UserPurchaseService;

import jakarta.servlet.http.HttpServletRequest;
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
	 * 주문하기 뷰
	 * memno
	 */
	@GetMapping("/user/purchaseView")
	public String puchaseView(@RequestParam(value = "pnoList", required = true) String pnoListStr,
								HttpServletRequest request,
								Model model) {
		System.out.println("UserPurchaseController purchaseView() start ,,,");
		System.out.println("UserPurchaseController deleteShoppingProduct() pnoListStr ->"+pnoListStr);
		
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
		
		return "user/purchase";
	}
	
	/*
	 * 주문하기
	 * 
	 * 매장 결제
	 */
	@ResponseBody
	@RequestMapping("/api/user/s-purchase")
	public String storePurchase(@RequestBody List<Purchase> pList,
												HttpServletRequest request,
												Model model)
	{
		System.out.println("UserPurchaseController storePurchase() start ,,, ");
		for (Purchase purchase : pList) {
	        System.out.println("상품 번호: " + purchase.getPno());
	        System.out.println("상품 이름: " + purchase.getPname());
	        System.out.println("구매 수량: " + purchase.getSquantity());
	        System.out.println("상품 가격: " + purchase.getPprice());
	        System.out.println("결제 방법 코드: " + purchase.getOpayment_mcd());
	        System.out.println("총 결제 금액: " + purchase.getOtotal_price());
	    }
		
		int memno = SessionUtil.getNo(request);
		int opayment_mcd = pList.get(0).getOpayment_mcd();
		int ototal_price = pList.get(0).getOtotal_price();
		
		Map<String, Object> pMap = new HashMap<>();
		
		pMap = ps.skPurchase(pList, memno, opayment_mcd, ototal_price);
		
		model.addAttribute(pMap);
		
		return "redirect:/user/purchaseResult";
	}	
	
	
	
	private final KakaoPayService ks;
	
	/*
	 * 주문하기
	 * 
	 * 카카오페이
	 */
	@PostMapping("/api/user/k-purchase")
	public @ResponseBody ReadyResponse kakaoPurchaseReady(@RequestBody List<Purchase> pList,
										HttpServletRequest request,
										Model model)
	{
	// 상품 이름 (2개 이상이면 ~외 ~개)
		String pname = null;
		if(pList.size() == 1) {
			pname = pList.get(0).getPname();
		} else if(pList.size() >= 2) {
			String firstPname = pList.get(0).getPname();
			int aCount = pList.size() - 1;
			pname = firstPname + " 외 " + aCount + " 개";
		}		
		
		int ototal_price = pList.get(0).getOtotal_price();
		
		ReadyResponse readyResponse = ks.payReady(pname, ototal_price);
		
		return readyResponse;	
	}
	@GetMapping("/user/kakaopay/completed")
	public String kakaoPurchaseCompleted(@RequestParam("pg_token") String pgToken) {
		String tid = SessionUtil.getStringAttributeValue("tid");
		log.info("결제승인 요청을 인증하는 토큰: " + pgToken);
        log.info("결제 고유번호: " + tid);

        // 카카오 결제 요청하기
        ApproveResponse approveResponse = ks.payApprove(tid, pgToken);
        
		return "redirect:/user/purchaseResult";
	}

	
	
	
	/*
	 * 주문완료 뷰
	 * orderno
	 */
	@RequestMapping("/user/purchaseResult")
	public String purchaseResultView() {
		System.out.println("UserPurchaseController purchaseResultView() start ,,,");
		System.out.println("");
		
		
		return "user/purchaseResult";
	}
}
