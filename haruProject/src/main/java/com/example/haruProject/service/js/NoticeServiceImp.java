package com.example.haruProject.service.js;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.haruProject.dao.js.NoticeDao;
import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class NoticeServiceImp implements NoticeService {
	
	private final NoticeDao nd;
	
	/**
	 * 공지사항 상태 공통데이터 조회 (노출, 비노출)
	 */
	@Override
	public List<Map<String, Object>> getStatusList() {
		List<Map<String, Object>> statusList = new ArrayList<>();
		
		statusList = nd.getStatusList();
	
		return statusList;
	}
	
	/**
	 * 공지사항 상태 공통데이터 전체 조회(상단고정 포함)
	 */
	@Override
	public List<Map<String, Object>> getAllStatusList() {
		List<Map<String, Object>> statusList = new ArrayList<>();
		
		statusList = nd.getAllStatusList();
	
		return statusList;
	}
	

	
	/**
	 * 공지사항 전체 수
	 */
	@Override
	public int getTotalCnt(SearchItem si) {
		int totalCnt = nd.getTotalCnt(si);
		return totalCnt;
	}

	/**
	 * 공지사항 리스트
	 * 페이지네이션, 필터 적용
	 */
	@Override
	public List<Notice> noticeList(int startRow, int endRow, SearchItem si) {
		List<Notice> nList = new ArrayList<>();
		nList = nd.noticeList(startRow, endRow, si);
		
		return nList;	
	}
	
	/**
	 * 상단고정 공지사항 불러오기
	 */
	@Override
	public List<Notice> topList() {
		List<Notice> tList = new ArrayList<>();
		tList = nd.topList();
		return tList;
	}

	/**
	 * 공지사항 작성
	 */
	@Override
	public void uploadNotice(Notice notice) {
		nd.uploadNotice(notice);
		
	}

	/**
	 * 공지사항 상세
	 */
	@Override
	public Notice getNoticeDetail(int nno) {
		Notice notice = new Notice();
		notice = nd.getNoticeDetail(nno);
		
		return notice;
	}

	/**
	 * 공지사항 수정
	 */
	@Override
	public void updateNotice(Notice notice) {
//		System.out.println("updatNotice Service");
//		System.out.println("서비스: "+notice);
		
		nd.updateNotice(notice);
		
	}

	/**
	 * 유저 공지사항 무한스크롤
	 */
	@Override
	public List<Notice> getNoticeList(int startRow, int endRow) {
		List<Notice> nList = new ArrayList<>();
		nList = nd.getNoticeList(startRow, endRow);
		
		return nList;
	}

	/**
	 * 공지사항 조회수 증가
	 */
	@Override
	public void plusViewCount(int nno) {
		nd.plusViewCount(nno);
	}


	
	
}
