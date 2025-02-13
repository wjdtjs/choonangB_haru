package com.example.haruProject.controller.admin.hj;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.controller.user.hr.KakaopayController;
import com.example.haruProject.dto.Common;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.OrderProduct;
import com.example.haruProject.service.hj.OrderService;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class OrderController {
	private final OrderService os;
	private final JavaMailSender mailSender;
	
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
		int totalCnt = os.getTotalCnt(si);
		
		//페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		// 판매리스트
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
		List<OrderProduct> products = os.getOrderProducts(orderno);
		// 주문상태값 대중분류
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
	public String updateOStatus (Order order1, HttpServletRequest requeset) {
		
		System.out.println("SaleController updateOStatus...");
		System.out.println("SaleController updateOStatus order1->"+order1);
		
		// 상태 변경 content 가져오기
		int result = os.updateOstatus(order1);
		String ostatus_content=os.getOstatusContent(order1.getOstatus_mcd());
		order1.setOstatus_content(ostatus_content);
		
		// 주문 상품 정보
		List<OrderProduct> products = os.getOrderProducts(order1.getOrderno());
		// 총결제금액
		int totalPrice = os.TotalPrice(order1.getOrderno());
		
		System.out.println("products-> "+products);
		System.out.println("totalPrice-> "+totalPrice);
		
		
		if (result > 0) {
			int mailResult = mailTransport(order1,products,totalPrice, requeset);
			System.out.println("메일 전송 성공 여부: "+ mailResult);
		}else {
			System.out.println("주문상태 수정 실패");
		}
		
		return "redirect:shop";
	}
	
	
	
	/**
	 * 
	 * @Scheduled
	 * 픽업대기 3일 지난 주문 내역 > 주문 취소
	 * 
	 */
	//@Scheduled(cron = "0 0 0 * * *")
	
	private final KakaopayController kc;
	
	@Scheduled(fixedRate = 3600000)
	public void autoOrderCancel() {
		log.info("auto order cancel start ,,,");
		
		List<Order> oList = os.autoOrderCancel();
		System.out.println("oList ->"+oList);
		
		for (Order order : oList) {
			int oMcd = order.getOpayment_mcd();
			// System.out.println("oMcd ->"+oMcd);
			
			if (oMcd == 300) {
				// 카카오페이 결제 취소
				Map<String, String> kMap = new HashMap<>();
				kMap.put("tid", order.getTid());
				kMap.put("ototal_price", String.valueOf(order.getOtotal_price()));
				kMap.put("ostatus_mcd", String.valueOf(order.getOstatus_mcd()));
				kMap.put("opayment_mcd", String.valueOf(oMcd));
				kMap.put("orderno", String.valueOf(order.getOrderno()));
				
				kc.refund(kMap);
			} else if (oMcd == 400) {
				// 매장 결제 취소
				order.setOstatus_mcd(400);
				os.updateOstatus(order);
			} else {
				System.out.println("oMcd -> "+oMcd);
				order.setOstatus_mcd(400);
				os.updateOstatus(order);
			}
		}
	}
	
	private int mailTransport (
									Order order, 
									List<OrderProduct> products,
									int totalPrice,
									HttpServletRequest requeset
								) {
		int result = 0;
		
		System.out.println("mailSending...");
		String tomail = order.getMemail();
		String setfrom = "as@naver.com";
		String title = "주문하신 상품이 " + order.getOstatus_content() + "되었습니다.";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper= new MimeMessageHelper(message,true,"UTF-8");
			messageHelper.setFrom(setfrom); 	// 보내는 사람 생략하서나 하면 정상작동을 안함
			messageHelper.setTo(tomail);		// 받는사람 이메일
			messageHelper.setSubject(title);	// 메일제목은 생략 가능
			
			StringBuffer content = new StringBuffer();
			content.append("<html><body>")
					.append("<h2>주문 상세 정보</h2>")
					.append("<table border='1' style='border-collapse: collapse; width: 100%; text-align: center;'>")
					.append("<tr><th>상품명</th><th>수량</th><th>가격</th></tr>");
			
			for (OrderProduct product : products) {
				content.append("<tr>")
						.append("<td>").append(product.getPname()).append("</td>")
						.append("<td>").append(product.getOquantity()).append("</td>")
						.append("<td>").append(product.getPprice()).append("</td>")
						.append("</tr>");
			}
			
			 content.append("</table>")
             		.append("<p><strong>총 가격: ").append(totalPrice).append("원</strong></p>")
             			.append("<p>감사합니다.</p>")
             				.append("</body></html>");
			 
			 messageHelper.setText(content.toString(), true); // HTML 사용 가능하도록 true 설정
		        

			mailSender.send(message);
			
			result = 1;
		} catch (Exception e) {
			System.out.println("mailTransport e.getMessage()->"+e.getMessage());
			result = 0;
		}
		return result;
	}
}
