package com.example.haruProject.dao.js;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Notice;
import com.example.haruProject.dto.SearchItem;

public interface NoticeDao {

	List<Map<String, Object>> getStatusList();
	List<Map<String, Object>> getAllStatusList();
	int getTotalCnt(SearchItem si);
	List<Notice> noticeList(int startRow, int endRow, SearchItem si);
	void uploadNotice(Notice notice);
	Notice getNoticeDetail(String nno);
	void updateNotice(Notice notice);

}
