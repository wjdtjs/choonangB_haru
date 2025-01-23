package com.example.haruProject.service.hr;

import java.util.List;
import java.util.Map;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.Schedule;
import com.example.haruProject.dto.SearchItem;

public interface AppointmentService {
	
	// 예약 내역
	int getTotalCnt(SearchItem si);
	List<Appointment> appointmentList(int startRow, int endRow, SearchItem si);
	
	// 예약 상세
	Appointment appointmentDetail(String resno);
	
	// 예약 수정
	int updateReservation(String resno, int rtime, String memo, int status);
	
	// 예약 추가
	List<Map<String, Object>> getBCDList();
	List<Map<String, Object>> getMCDList(int bcd);
	List<Map<String, Object>> getDocList();
	List<Schedule> getDisabledDatesList(int ano);
	
	// 진료 내역
	int getTotalCntChart(SearchItem si);
	List<Appointment> consultationListChart(int startRow, int endRow, SearchItem si);

}
