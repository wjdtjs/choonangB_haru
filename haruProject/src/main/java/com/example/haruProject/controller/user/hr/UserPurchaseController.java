package com.example.haruProject.controller.user.hr;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.dto.ShoppingCart;
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
}
