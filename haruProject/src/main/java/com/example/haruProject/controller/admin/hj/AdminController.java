package com.example.haruProject.controller.admin.hj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.haruProject.common.utils.SessionUtil;
import com.example.haruProject.dto.Admin;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.hj.AdminService;
import com.example.haruProject.service.js.MemberService;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminController {
	
	private final AdminService as;
	private final MemberService ms;
	private final PasswordEncoder passwordEncoder;
	
	// 관리자 리스트
	@ResponseBody
	@GetMapping(value = "/api/admin-list")
	public Map<String, Object> adminList(
											@RequestParam(value = "pageNum", required = true) String pageNum,
											@RequestParam(value = "blockSize", required = false, defaultValue = "10")String blockSize,
											@RequestParam(value = "search1", required = false)String search1,
											@RequestParam(value = "search2", required = false)String search2
										){
		System.out.println("AdminController adminList");
		
		List<Admin> aList = new ArrayList<>();
		Map<String, Object> aListMap = new HashMap<>();
		
		// 검색필터
		SearchItem si = new SearchItem(search1,search2);
		
		// 상품 전체 수 (필터 적용)
		int totalCnt = as.getTotalCnt(si);
		
		// 페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, Integer.parseInt(blockSize));
		
		//페이지네이션 적용된 상품 목록
		aList = as.adminList(pagination.getStartRow(), pagination.getEndRow(), si);
		System.out.println("aList->"+aList);
		
		
		aListMap.put("pagination", pagination);
		aListMap.put("list", aList);
		
		System.out.println("AdminController adminList aListMap->"+aListMap);
		
		return aListMap;
	}

	// 관리자 추가 : Role
	@ResponseBody
	@GetMapping(value = "/api/alevel-mcd")
	public Map<String,Object> adminLevelMcd (){
		System.out.println("AdminController adminLevelMcd Start,,,");
		List<Admin> alevelList = new ArrayList<>(); 
		Map<String, Object> alevelMap = new HashMap<>();
	  
		alevelList = as.adminLevelMcd();
		alevelMap.put("alevelList", alevelList);
		System.out.println(alevelMap);
		return alevelMap;
	  
	}
	 
	@ResponseBody
	@PostMapping(value = "/api/addAdmin")
	public ModelAndView addAdminAPI(Admin admin,RedirectAttributes redirectAttributes) {
		System.out.println("AdminController addAdmin Start,,,");
		
		System.out.println("관리자 추가 -> "+admin);
		String passwd = admin.getApasswd();
		
		String encodedPassword = passwordEncoder.encode(passwd);
		System.out.println("pw 암호화: "+encodedPassword);
		
		admin.setApasswd(encodedPassword); //암호화된 패스워드 저장
		admin.setRe_apasswd(encodedPassword);
		
		// 핸드폰번호 형식 변환
		String tel = formatPhoneNumber(admin.getAtel());
		admin.setAtel(tel);
		
		// 관리자추가
		int addAdminResult = as.adminAdd(admin);
		System.out.println("AdminController addAdmin addAdmin ->"+ addAdminResult);
		
		// 추가결과 -> jsp alert
		if(addAdminResult >0) {
			 redirectAttributes.addFlashAttribute("message", "관리자 등록이 완료되었습니다.");
		}else {
	        redirectAttributes.addFlashAttribute("message", "관리자 등록에 실패했습니다.");
	    }
		
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("redirect:/admin/doctor"); // 리다이렉트할 URL 설정
	    return modelAndView;
	}
	
	
	// 관리자 정보 수정 : Role, 상태 가져옴
	/*
	 * @ResponseBody
	 * 
	 * @GetMapping(value = "/api/admin-common") public Map<String, Object>
	 * adminBcdMcd() { System.out.println("AdminController adminBcdMcd Start,,,");
	 * 
	 * List<Admin> commonList = new ArrayList<>(); Map<String, Object> commonMap =
	 * new HashMap<>();
	 * 
	 * commonList = as.adminBcdMcd(); commonMap.put("adminCommon", commonList);
	 * 
	 * return commonMap; }
	 */
	
	// 관리자 정보
	   @GetMapping(value = "/admin/detailAdmin")
	   public String getAdminDetail(
	                           HttpServletRequest request, 
	                           @RequestParam("ano") String ano, 
	                           Model model) {
	      System.out.println("AdminController getAdminDetail... ");
	      System.out.println("AdminController getAdminDetailano- >"+ano);
	      
	      int userno = SessionUtil.getNo(request); // 현재 로그인 정보
	      int userrole = SessionUtil.getRole(request); // 현재 로그인 정보
	      //System.out.println("AdminController getAdminDetailano userno- >"+userno);
	      //System.out.println("AdminController getAdminDetailano userrole- >"+userrole);
	      
	      Admin admin = as.getAdminDetail(Integer.parseInt(ano));
	      System.out.println("AdminController getAdminDetailano admin- >"+admin);
	      
	      List<Map<String, Object>> acommonList=as.acommonList();
	      System.out.println("AdminController getAdminDetailano acommonList- >"+acommonList);
	      
	      model.addAttribute("userno",userno);
	      model.addAttribute("userrole",userrole);
	      model.addAttribute("admin",admin);
	      model.addAttribute("common",acommonList);
	      model.addAttribute("pageNum",1);

	      return "admin/detailAdmin";
	   }
	
	// 관리자 정보 수정
	@PostMapping(value = "/admin/updateAdmin")
	public String updateAdmin (Admin admin, Model model, RedirectAttributes redirectAttributes) {
		System.out.println("AdminController updateAdmin...");
		System.out.println("AdminController updateAdmin admin->"+admin);
		
		Admin info = ms.chkAdminExist(admin);
		int result = 0;
		
		if(passwordEncoder.matches(admin.getApasswd(), info.getApasswd())) {
			System.out.println("일치");
			
			// 핸드폰번호 형식 변환
			String tel = formatPhoneNumber(admin.getAtel());
			admin.setAtel(tel);
			
			result = as.updateAdmin(admin);			
		} else {
			System.out.println("불일치");
			model.addAttribute("result", 0);
		}
		
		// 추가결과 -> jsp alert
		if(result >0) {
			redirectAttributes.addFlashAttribute("message", admin.getAname()+"("+admin.getAno()+")님의 수정이 완료되었습니다.");
		}else {
			redirectAttributes.addFlashAttribute("message", admin.getAname()+"("+admin.getAno()+")님의 수정에 실패했습니다.");
		}
		
		return "redirect:/admin/doctor";
		
	}
	
	// 휴대폰번호 형식변환
	private String formatPhoneNumber(String phone) {
		phone = phone.replaceAll("\\D", ""); //숫자만 남기기
		if(phone.length() == 11) {
			return phone.replaceFirst("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");
		}else if (phone.length() == 10) {
			return phone.replaceFirst("(\\d{3})(\\d{3})(\\d{4})", "$1-$2-$3");
		}
		return phone; //형식이 맞지 않으면 그대로 리턴
	}
}
