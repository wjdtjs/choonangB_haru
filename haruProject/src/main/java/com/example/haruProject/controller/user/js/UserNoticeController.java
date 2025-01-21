package com.example.haruProject.controller.user.js;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.Pagination;
import com.example.haruProject.dto.SearchItem;
import com.example.haruProject.service.js.NoticeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class UserNoticeController {
	private final NoticeService ns;
	
	/**
	 * 사용자페이지 - 공지사항 뷰 
	 * @return
	 */
	@GetMapping("/user/notice")
	public String noticeView(@RequestParam(value = "pageNum", required = true, defaultValue="1") String pageNum,
							 @RequestParam(value = "blockSize", required = false, defaultValue="10") int blockSize,
							Notice notice, Model model) 
	{
		log.info("noticeView() start..");
		
		//검색
		SearchItem si = new SearchItem("", 100);
		
		//공지사항 전체 수 (필터 적용)
		int totalCnt = ns.getTotalCnt(si);
		//페이지네이션
		Pagination pagination = new Pagination(totalCnt, pageNum, blockSize);
		System.out.println(pagination);
		
		List<Notice> noticeList = new ArrayList<>();
		noticeList = ns.noticeList(pagination.getStartRow(), pagination.getEndRow(), si);

		List<Notice> topList = new ArrayList<>();
		
		topList = ns.topList();
		noticeList.addAll(0, topList);
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("nList", noticeList);
		
		return "user/notice";
	}
	
	
	/**
	 * 무한스크롤 공지사항
	 * @param totalCnt
	 * @param pageNum
	 * @return
	 */
	@ResponseBody
	@GetMapping("/api/notice-list")
	public Map<String, Object> getNoticeList(
			@RequestParam(value="totalCnt", required = true) String totalCnt,
			@RequestParam(value="pageNum", required = true) String pageNum) 
	{
		log.info("getNoticeList API start..");
		Map<String, Object> nMap = new HashMap<>();
		
		List<Notice> nList = new ArrayList<>();
		
		Pagination pagination = new Pagination(Integer.parseInt(totalCnt), pageNum, 10);
		nList = ns.getNoticeList(pagination.getStartRow(), pagination.getEndRow());
		
		nMap.put("pagination", pagination);
		nMap.put("nList", nList);
		
		return nMap;
	}
	
	/**
	 * 유저 공지사항 조회
	 * @param notice
	 * @param model
	 * @return
	 */
	@GetMapping("/user/details-notice")
	public String detailsNoticeView(Notice notice, Model model) {
		log.info("detailsNoticeView() start..");
		
		int nno = notice.getNno();
		
		//조회수 증가
		ns.plusViewCount(nno);
		
		notice = ns.getNoticeDetail(nno);
		model.addAttribute("notice", notice);
		
		return "user/detailsNotice";
	}
	
	
}
