package com.example.haruProject.dao.js;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.SearchItem;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class NoticeDaoImp implements NoticeDao {
	
	private final SqlSession session;

	/**
	 * 공지사항 상태 공통데이터 조회 (노출, 비노출)
	 */
	@Override
	public List<Map<String, Object>> getStatusList() {
		List<Map<String, Object>> statusList = new ArrayList<>();
		
		try {
			statusList = session.selectList("JS_SelectNoticeStatus");			
		} catch (Exception e) {
			log.error("getStatusList() query error -> ", e.getMessage());
		}
		
		return statusList;
	}
	
	/**
	 * 공지사항 상태 공통데이터 전체 조회 (상단고정 포함)
	 */
	@Override
	public List<Map<String, Object>> getAllStatusList() {
		List<Map<String, Object>> statusList = new ArrayList<>();
		
		try {
			statusList = session.selectList("JS_SelectAllNoticeStatus");			
		} catch (Exception e) {
			log.error("getAllStatusList() query error -> ", e.getMessage());
		}
		
		return statusList;
	}

	
	
	/**
	 * 공지사항 전체 수
	 */
	@Override
	public int getTotalCnt(SearchItem si) {
		int totalCnt = 0;
		
		try {
			totalCnt = session.selectOne("JS_SelectTotalNoticeCnt", si);			
		} catch (Exception e) {
			log.error("getTotalCnt() query error -> ", e.getMessage());
		}
		
		return totalCnt;
	}

	/**
	 * 공지사항 리스트 조회
	 */
	@Override
	public List<Notice> noticeList(int startRow, int endRow, SearchItem si) {
		List<Notice> nList = new ArrayList<>();
		
		Map<String, Object> parameterMap = new HashMap<>();
		parameterMap.put("startRow", startRow);
		parameterMap.put("endRow", endRow);
		parameterMap.put("search", si);
		
		try {
			nList = session.selectList("JS_SelectNoticeList", parameterMap);
		} catch (Exception e) {
			log.error("noticeList() query error -> ", e);
		}
		
		System.out.println(nList);
		return nList;
	}

	/**
	 * 공지사항 작성
	 */
	@Override
	public void uploadNotice(Notice notice) {
		
		try {
			session.insert("JS_InsertNotice", notice);
		} catch (Exception e) {
			log.error("uploadNotice() query error -> ", e);
		}
		
	}

	/**
	 * 공지사항 상세
	 */
	@Override
	public Notice getNoticeDetail(String nno) {
		Notice notice = new Notice();
		try {
			notice = session.selectOne("JS_SelectNoticeDetail", nno);
		} catch (Exception e) {
			log.error("getNoticeDetail() query error -> ", e);
		}
		
		return notice;
	}

	/**
	 * 공지사항 수정
	 */
	@Override
	public void updateNotice(Notice notice) {
		System.out.println("2222222222222");
		try {
			session.update("JS_UpdateNotice", notice);
		} catch (Exception e) {
			log.error("updateNotice() query error -> ", e);
		}
		
	}

	
	
}
