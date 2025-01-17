package com.example.haruProject.controller.admin.js;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.js.NoticeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class NoticeController {
	
	private final NoticeService ns;
	
	/**
	 * 관리자페이지 공지사항관리 뷰
	 * @return
	 */
	@GetMapping("/admin/notice")
	public String noticeView(@RequestParam(value = "pageNum", required = true, defaultValue="1") String pageNum,
							 @RequestParam(value = "blockSize", required = false, defaultValue="10") String blockSize,
							 @RequestParam(value = "search1", required = false) String search1,
							 @RequestParam(value = "search2", required = false) String search2,
							 Notice notice, Model model ) 
	{
		log.info("noticeView() start..");
//		System.out.println("pageNum : "+pageNum);
//		System.out.println("blockSize : "+blockSize);
//		System.out.println(search1);
//		System.out.println(search2);
		
		
		//상태 정보
		List<Map<String, Object>> statusList = new ArrayList<>();
		statusList = ns.getStatusList();
//		System.out.println(statusList);
		
		//검색
		SearchItem si = new SearchItem(search1, search2);
		
		//공지사항 전체 수 (필터 적용)
		int totalCnt = ns.getTotalCnt(si);
		//페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, totalCnt);
		
		List<Notice> noticeList = new ArrayList<>();
		noticeList = ns.noticeList(pagination.getStartRow(), pagination.getEndRow(), si);
		
		model.addAttribute("statusList", statusList);
		model.addAttribute("pagination", pagination);
		model.addAttribute("nList", noticeList);
		
		return "admin/notice";
	}
	
	/**
	 * 공지사항 등록 뷰
	 * @return
	 */
	@GetMapping("/admin/upload-notice")
	public String uploadNoticeView(Model model) {
		log.info("uploadNoticeView() start..");
		
		//상태 정보
		List<Map<String, Object>> statusList = new ArrayList<>();
		statusList = ns.getAllStatusList();
		
		model.addAttribute("statusList", statusList);
		
		return "admin/uploadNotice";
	}
	
	/**
	 * 공지사항 등록
	 * @return
	 */
	@PostMapping("/admin/uploadNotice")
	public String uploadNotice(Notice notice, Model model) {
		log.info("uploadNotice() start..");
		
//		System.out.println(notice);
		
		ns.uploadNotice(notice);
		
		return "redirect:notice";
	}
	
	/**
	 * 공지사항 상세 뷰
	 * @param notice
	 * @param model
	 * @param nno
	 * @return
	 */
	@GetMapping("/admin/details-notice")
	public String detailsNoticeView(Notice notice, Model model, @RequestParam("nno") String nno) {
		log.info("detailsNoticeView() start..");
		
		//상태 정보
		List<Map<String, Object>> statusList = new ArrayList<>();
		statusList = ns.getAllStatusList();
		
		//상세 정보
		notice = ns.getNoticeDetail(nno);
		
		model.addAttribute("statusList", statusList);
		model.addAttribute("notice", notice);
		
		return "admin/detailsNotice";
	}
	
	/**
	 * 공지사항 수정
	 * @param notice
	 * @param model
	 * @return
	 */
	@PostMapping("/admin/updateNotice")
	public String updateNotice(Notice notice, Model model) {
		log.info("updateNotice() start..");
		System.out.println("000000000000000000");
		
		System.out.println(notice);
		ns.updateNotice(notice);
		
		return "redirect:notice";
	}
}
