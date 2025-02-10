package com.example.haruProject.controller.user.hj;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.controller.admin.js.UploadController;
import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProduct;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.hj.PurchaseHistoryService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class PurchaseHistoryController {
	private final PurchaseHistoryService ps;
	
	/* 구매내역 가져오기 */
	@GetMapping(value = "/user/purchaseHistory")
	public String getPurchaseHistory(	
										HttpServletRequest request,
										Model model,
										@RequestParam(value = "type4", defaultValue = "1") int type4
									) {
		System.out.println("PurchaseHistoryController getPurchaseHistory ...");
		
		/* 구매 내역 */
		int memno = SessionUtil.getNo(request);
		SearchItem si = new SearchItem(type4);
		List<Order> purchaseList = ps.getPurchaseHistory(memno, si);
		
		for (int i = 0 ; i<purchaseList.size() ; i++) {
			int orderno  = purchaseList.get(i).getOrderno();
			List<OrderProduct> products = ps.getPurchaseProduct(orderno);
			
			purchaseList.get(i).setProductList(products);		
		}
		
		System.out.println("purchaseList: "+purchaseList);
		
		/* 리뷰 작성 여부*/
		
		model.addAttribute("purchaseList",purchaseList);
		model.addAttribute("si",si);
		return "user/purchaseHistory";
	}
	
	/* 상품후기 작성 뷰*/
	@RequestMapping(value = "/user/writeProductReview")
	public String writeReviewForm(	
									HttpServletRequest request,
									OrderProduct product,
									Model model
								 ) {
		System.out.println("PurchaseHistoryController writeReviewForm...");
		System.out.println("PurchaseHistoryController writeReviewForm product->"+product);
		OrderProduct op = ps.getReviewProduct(product);
		
		model.addAttribute("product",op);

		return "user/writeProductReviewForm";
	}
	
	/* 상품후기 작성*/
	@PostMapping(value = "/user/addProductReview")
	public String addProducrReview(
									HttpServletRequest request,
									Board board,
									Model model
								  ) {
		
		System.out.println("PurchaseHistoryController addProductReview ...");
		
		String type = "board";
		String imgPath = saveImage(type, request);
		
		if(imgPath==null) {
			return "redirect:/user/purchaseHistory";
		} else {
			board.setBimg(imgPath); //썸네일 이름 객체에 저장			
		}
		
		int memno = SessionUtil.getNo(request);
		String pname = ps.getPname(board.getPno());
		
		board.setBtitle(pname);
		board.setMemno(memno);
		
		System.out.println("PurchaseHistoryController addProductReview board-> "+board);

		int result = ps.addProductReview(board);
		
		return "redirect:/user/purchaseHistory";
	}
	
	/**
	 * 이미지 저장
	 * @param type
	 * @param request
	 * @return
	 */
	private String saveImage(String type, HttpServletRequest request) {
		UploadController uc = new UploadController();
		String imgPath = null;
		
		////썸네일 저장
		try {
			Part image = request.getPart("main_img");
			System.out.println(image);
			InputStream inputStream = image.getInputStream();
			
			// 파일 확장자 구하기
			String fileName = image.getSubmittedFileName();
			String[] split = fileName.split("\\.");
			String suffix = split[split.length -1];
			
			log.info("fileName -> {}", fileName);
			log.info("suffix -> {}",suffix);
			
			// Servlet 상속 받지 못했을 때 realPath 불러오는 방법
			String type_path = "/upload/"+type+"/";
			String uploadPath = request.getSession().getServletContext().getRealPath(type_path);
			System.out.println("real path : "+uploadPath);
			
			log.info("uploadForm() POST Start..");
			String savedName = uc.uploadFile(type, inputStream, uploadPath, suffix);
			
			log.info("Return savedName: {}", savedName);			
			imgPath = type_path+savedName;
			System.out.println(imgPath);
			
		} catch (Exception e) {
			System.out.println("image upload error : "+ e.getMessage());
		}
		
		return imgPath;
	}
	
	/* 상품후기 뷰*/
	@GetMapping(value = "/user/productReview")
	public String ProductReviewView(OrderProduct op, Model model) {
		System.out.println("PurchaseHistoryController ProductReviewView ...");
		
		OrderProduct product = ps.getReviewProduct(op);
		Board board = ps.getProductReview(op);

		model.addAttribute("product",product);
		model.addAttribute("board",board);
		return "user/productReviewView";
	}
	
	/* 상품후기 수정 뷰*/
	@GetMapping(value = "/user/updateProductReviewView")
	public String updateProductReviewView(OrderProduct op, Model model) {
		System.out.println("PurchaseHistoryController ProductReviewView ...");
		
		OrderProduct product = ps.getReviewProduct(op);
		Board board = ps.getProductReview(op);

		model.addAttribute("product",product);
		model.addAttribute("board",board);
		
		return "user/updateProductReviewForm";
	}
	
	/* 상품후기 수정*/
	@PostMapping(value = "/user/updateProductReview")
	public String updateProductReview(
										HttpServletRequest request,
										Board board,
										Model model
									  ) throws IOException, ServletException {
		System.out.println("PurchaseHistoryController updateProductReview ...");
		
		boolean img_change = false;
		String type = "board";
		String imgPath = null;
		
		Part image = request.getPart("main_img");
		if(image.getSize() == 0 ) {
			System.out.println("이미지 변경 안함");
		} else {			
			System.out.println("이미지 변경함");
			
			imgPath = saveImage(type, request);
			if(imgPath==null) {
				 return "/user/purchaseHistory";

			} else {
				board.setBimg(imgPath); //썸네일 이름 객체에 저장
				img_change = true;
			}
		}
		 
		
		int result = ps.updateProductReview(board, img_change);
		
		return "redirect:/user/purchaseHistory";
	}
	
	@RequestMapping(value = "/user/deleteProductReview")
	public String deleteProductReview(Board board) {
		System.out.println("PurchaseHistoryController deleteProductReview ...");

		int result = ps.deleteProductReview(board);
		
		return "redirect:/user/purchaseHistory";
	}
	
}
