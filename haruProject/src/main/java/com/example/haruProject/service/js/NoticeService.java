package com.example.haruProject.service.js;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.SearchItem;

public interface NoticeService {

	List<Map<String, Object>> getStatusList();
	List<Map<String, Object>> getAllStatusList();
	int getTotalCnt(SearchItem si);
	List<Notice> noticeList(int startRow, int endRow, SearchItem si);
	void uploadNotice(Notice notice);
	Notice getNoticeDetail(int i);
	void updateNotice(Notice notice);
	List<Notice> topList();
	List<Notice> getNoticeList(int startRow, int endRow);
	void plusViewCount(int nno);

}
