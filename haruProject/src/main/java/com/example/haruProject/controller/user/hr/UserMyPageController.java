package com.example.haruProject.controller.user.hr;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.dto.Board;
import com.example.haruProject.dto.Member;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.Pet;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.hr.UserMemberService;
import com.example.haruProject.service.hr.UserPetService;
import com.example.haruProject.service.js.ReviewService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class UserMyPageController {

	private final UserMemberService ms;
	private final ReviewService rs;
	private final UserPetService ps;
	private final PasswordEncoder passwordEncoder;
	
	/**
	 * 사용자페이지 - 마이페이지 뷰 
	 * @return
	 */
	@GetMapping("/user/myPage")
	public String UserMyPageView(Model model, HttpServletRequest request) {		
		log.info("myPage view start ,,,");
		
		int memno = SessionUtil.getNo(request);
		
		System.out.println("UserPetController getPet() memno ->"+memno);

		List<Pet> pList = ps.getPetList(memno);
		
		model.addAttribute("pList", pList);
		
		return "user/myPage";
	}
	
	/**
	 * 내 정보 수정 뷰
	 * @return
	 */
	@GetMapping("/user/editMyinfo")
	public String editMyinfoView(HttpServletRequest request, Model model) {
		System.out.println("UserMyPageController editMyinfoView() start ,,,");
		
		int memno = SessionUtil.getNo(request);
		
		System.out.println("UserMyPageController editMyinfoView() memno-> "+memno);
		
		Member member = ms.getMyinfo(memno);
		
		model.addAttribute("member", member);
		model.addAttribute("edit_true", true);
		
		return "user/editMyinfo";
	}
	
	
	
	@Value("${kakao.admin-key}")
    String AdminKey;	
	
	
	/**
	 * 회원 탈퇴
	 * @return
	 */
	@RequestMapping("/user/deleteMember")
	public String deleteMember(HttpServletRequest request) {
		System.out.println("UserMyPageController deleteMember() start ,,,");
		int memno = SessionUtil.getNo(request);
		
		System.out.println("UserMyPageController deleteMember() memno ->"+memno);
		
		
		// 카카오 로그인 탈퇴
		if(SessionUtil.getType(request).equals("GK")) {
			System.out.println("카카오 로그인 유저 탈퇴 요청");
			String reqURL = "https://kapi.kakao.com/v1/user/unlink";
			String target_id = ms.getUserID(memno);
			
			
			try {
				
				URL url = new URL(reqURL);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	
	            //POST 요청을 위해 기본값이 false인 setDoOutput을 true로
	            conn.setRequestMethod("POST");
	            conn.setDoOutput(true);
	            conn.setRequestProperty("Authorization", "KakaoAK "+AdminKey);
	            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
	
	            //POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
	            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	            StringBuilder sb = new StringBuilder();
	            sb.append("&target_id="+target_id);
	            sb.append("&target_id_type=user_id"); 
	            bw.write(sb.toString());
	            bw.flush();
	
	            //결과 코드가 200이라면 성공
	            int responseCode = conn.getResponseCode();
	            System.out.println("카카오 탈퇴 responseCode : " + responseCode);
	             
	            bw.close();
			} catch (Exception e) {
				e.printStackTrace();
				return "redirect:/user/myPage";
			}
			
		}
		
		
		int result = ms.deleteMember(memno);
		
		return "redirect:/all/user/login";
	}
	
	/**
	 * 회원 정보 수정
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/user/updateMember")
	public String updateMember(@ModelAttribute("member") Member member, RedirectAttributes redirectAttributes) {
		System.out.println("UserMyPageController updateMember() start ,,,");
		System.out.println("UserMyPageController updateMember() member ->"+member);	
		
		Member real_mem = ms.getRealPasswd(member.getMemno());
		System.out.println("updateMember() real_mem ->"+real_mem);
		
		System.out.println("UserMyPageController updateMember() member.getRe_mpasswd ->"+member.getRe_mpasswd());
		System.out.println("UserMyPageController updateMember() real_mem.getMpasswd ->"+real_mem.getMpasswd());
		
		if (passwordEncoder.matches(member.getRe_mpasswd(), real_mem.getMpasswd())) {
			System.out.println("비밀번호 일치, 정보 수정 시작");
			
			String passwd = member.getMpasswd();
			System.out.println("passwd ->"+passwd);
			// 새로운 비밀번호 암호화
			if (passwd != null && passwd != "" && passwd != " ") {
				String encodedPassword = passwordEncoder.encode(passwd);
				System.out.println("암호화: "+encodedPassword);
				member.setMpasswd(encodedPassword);							
			}
			
			int result = 0;
			result = ms.updateMember(member);
			
			if (result > 0) {
				System.out.println("정보 수정 완료");
				return "redirect:/user/myPage"; // 수정 후 마이페이지로 이동
			} else {
				System.out.println("정보 수정 실패");
				return "redirect:/user/editMyinfo"; // 다시 수정 페이지로 이동
			}	
		} else {
			real_mem.setMpasswd(null);
			redirectAttributes.addFlashAttribute("member", real_mem);
			redirectAttributes.addFlashAttribute("edit_true", false);
			System.out.println("비밀번호 불일치, 정보 수정 실패");				
			return "redirect:/user/editMyinfo";
		}
		
	}
	
	/**
	 * 내 글 관리
	 * @return
	 */
	@GetMapping("/user/myCommunity")
	public String myCommunityView(@RequestParam(value = "pageNum", required = true, defaultValue="1") String pageNum,
								@RequestParam(value = "blockSize", required = false, defaultValue="10") int blockSize,
								@RequestParam(value = "search1", required = false, defaultValue="") String search1,
								@RequestParam(value = "type5", required = false, defaultValue="0") int type5,
								@RequestParam(value = "mcd", required = true, defaultValue = "999") int mcd,
								HttpServletRequest request,
								Board board, Model model) {
		log.info("myCommunityView() start ,,,");
		
		// 후기 중분류
		List<Map<String, Object>> mcdList = new ArrayList<>();
		mcdList = ms.getMcdList();
		
		// 제목 검색
		int memno = SessionUtil.getNo(request);
		SearchItem si = new SearchItem(mcd, memno, search1);
		System.out.println("UserMyPageController si-> "+si);
		
		//공지사항 전체 수 (필터 적용)
		int totalCnt = ms.getReviewCnt(si);
		//페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, blockSize);
		System.out.println(pagination);
		
		List<Board> rList = new ArrayList<>();
		rList = ms.getReviewList(pagination.getStartRow(), pagination.getEndRow(), si);
		
		List<Board> oList = new ArrayList<>();
		oList = ms.getTitleList();
		System.out.println("oList ->"+oList);
		
		// 댓글에 해당하는 원글 제목
		for (Board b1 : rList) {
			if(b1.getBtitle() == null) {
				for (Board b2 : oList) {
					if (b2.getBno() == b1.getBgroup()) {
						//System.out.println("bno: "+b2.getBno()+", bgroup: "+b1.getBgroup());
						b1.setOtitle(b2.getBtitle());
						//System.out.println("btitle: "+b2.getBtitle()+", otitle: "+b1.getOtitle());
						break;
					}
				}
			}
		}
		
		System.out.println(rList);		

		model.addAttribute("mcd", mcd);
		model.addAttribute("ismy", type5);
		model.addAttribute("title", search1);
		model.addAttribute("mcdList", mcdList);
		model.addAttribute("rList", rList);
		model.addAttribute("pagination", pagination);
			
		return "user/myCommunity";
		
	}
	
	@RequestMapping("/user/review-re-delete")
	public String reDelete(@RequestParam(value = "bno", required = true) int bno) {
		log.info("review-re-delete start ,,,");
		System.out.println("UserMyPageController reDelete() bno-> "+bno);
		
		int result = ms.deleteRe(bno);
		
		return "redirect:/user/myCommunity";
	}
	
	
	/**
	 * 로그아웃
	 * @return
	 */
	@RequestMapping("/user/rogout")
	public String rogoutAction(HttpServletRequest request) {
		SessionUtil.logout(request);
		return "redirect:/all/user/login";
	}
	
	
}
