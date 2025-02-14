package com.example.haruProject.controller.user.hr;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.dto.ApproveResponse;
import com.example.haruProject.dto.KakaoCancelResponse;
import com.example.haruProject.dto.Order;
import com.example.haruProject.dto.Purchase;
import com.example.haruProject.dto.ReadyResponse;
import com.example.haruProject.service.hj.OrderService;
import com.example.haruProject.service.hr.KakaoPayService;
import com.example.haruProject.service.hr.NotificationService;
import com.example.haruProject.service.hr.UserPurchaseService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class KakaopayController {
	
	private final UserPurchaseService ps;
	private final KakaoPayService ks;
	private final OrderService os;
	
	/*
	 * 주문하기
	 * 
	 * 카카오페이
	 */
	@RequestMapping("/api/user/k-purchase")
	public @ResponseBody ReadyResponse kakaoPurchaseReady(@RequestBody List<Purchase> pList,
										HttpServletRequest request) throws Exception
	{
	// 상품 이름 (2개 이상이면 ~외 ~개)
		String pname = (pList.size() == 1) ? pList.get(0).getPname() : pList.get(0).getPname() + " 외 " + (pList.size() - 1) + " 개";
//		String pname = null;
//		if(pList.size() == 1) {
//			pname = pList.get(0).getPname();
//		} else if(pList.size() >= 2) {
//			String firstPname = pList.get(0).getPname();
//			int aCount = pList.size() - 1;
//			pname = firstPname + " 외 " + aCount + " 개";
//		}
		
		int memno = SessionUtil.getNo(request);
		int ototal_price = pList.get(0).getOtotal_price();
		int opayment_mcd = pList.get(0).getOpayment_mcd();
		int dp = pList.get(0).getDp();
		System.out.println("dp ->"+dp);
		
		int orderno = ps.skPurchase(pList, memno, opayment_mcd, ototal_price, dp);
		
		ReadyResponse readyResponse = ks.payReady(pname, ototal_price, orderno, memno);
		
		return readyResponse;
	}
	
	private final NotificationService ns;
	
	// 카카오페이 결제 시작
	@GetMapping("/user/kakaopay/completed")
	public String kakaoPurchaseCompleted(@RequestParam("pg_token") String pgToken,
										@RequestParam("orderno") int orderno,
										Model model, HttpSession session,
										HttpServletRequest request) {
		String tid = SessionUtil.getStringAttributeValue("tid");
		log.info("결제승인 요청을 인증하는 토큰: " + pgToken);
        log.info("결제 고유번호: " + tid);
        log.info("주문 번호: " + orderno);
        
        int memno = SessionUtil.getNo(request);

        // 카카오 결제 요청하기
        ApproveResponse approveResponse = ks.payApprove(tid, pgToken, orderno, memno);
        
        
        if (approveResponse != null) {
        	// 카카오 페이 결제 성공
        	tid = approveResponse.getTid();
            System.out.println("결제 성공! 승인 번호: " + tid);
            
            // 주문 상태 0 -> 100, tid 입력 
            ps.updateKStatus(orderno, tid);
            
            // SSE 연결된 클라이언트가 있는지 확인 후 알림 전송
            //boolean notificationSent = ns.sendNotification("카카오페이 결제가 완료되었습니다!");
            boolean notificationSent = ns.sendNotification(" 새로운 주문이 추가되었습니다!", "#0C808D");
            
            if (!notificationSent) {
                System.out.println("SSE 연결된 클라이언트가 없음");
            }
            
            // 성공한 주문 정보를 모델에 추가
            model.addAttribute("tid", approveResponse.getTid());
            model.addAttribute("orderno", approveResponse.getPartner_order_id());

            return "user/purchaseResult"; // 결제 성공 페이지로 이동
        } else {
            // 승인 실패 시 실패 페이지로 이동
            return "redirect:/user/kakaopayFail";
        }
	}
	// 카카오페이 결제 취소
	@GetMapping("/user/kakaopay/cacel")
	public String kakaopayCancelView(Model model) {
		log.info("카카오 페이 결제 취소");
		
		// 취소 안내 메시지 저장
	    model.addAttribute("message", "결제가 취소되었습니다. 다시 시도해주세요.");
	    
		return "user/kakaopayCancel";
	}
	// 카카오페이 결제 실패
	@GetMapping("/user/kakaopay/fail")
	public String kakaopayFailView(@RequestParam(required = false) String error_code,
						            @RequestParam(required = false) String error_msg,
						            Model model) {
		log.info("카카오 페이 결제 실패");
		
		// 실패 이유를 모델에 저장하여 뷰에서 표시
	    model.addAttribute("error_code", error_code);
	    model.addAttribute("error_msg", error_msg);
	    
		return "user/kakaopayFail";
	}

	
	
	/*
	 * 카카오페이 결제 취소
	 * 
	 */
	@RequestMapping("/api/kakaopay/refund")
    public ResponseEntity<?> refund(@RequestBody Map<String, String> requestData) {
		System.out.println("kakaopay refund start ,,,");
		
		String tid = requestData.get("tid");
	    String ototal_price = requestData.get("ototal_price");
	    int ostatus_mcd = Integer.parseInt(requestData.get("ostatus_mcd"));
	    int orderno = Integer.parseInt(requestData.get("orderno"));
	    
	    Order order = new Order();
	    order.setOstatus_mcd(ostatus_mcd);
	    order.setOrderno(orderno);	    
	    
	    if (tid == null || ototal_price == null) {
	        return ResponseEntity.badRequest().body("필수 파라미터가 누락되었습니다.");
	    }
	    
		System.out.println("kakaopay refund tid ->"+tid);
		System.out.println("kakaopay refund ototal_price ->"+ototal_price);
		
		os.updateOstatus(order);
        KakaoCancelResponse kakaoCancelResponse = ks.kakaoCancel(tid, ototal_price);
        
        return new ResponseEntity<>(kakaoCancelResponse, HttpStatus.OK);
    }
}
