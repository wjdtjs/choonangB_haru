package com.example.haruProject.service.hr;

import java.util.List;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.SearchItem;

public interface AppointmentService {
	
	// 예약 내역
	int getTotalCnt(SearchItem si);
	List<Appointment> appointmentList(int startRow, int endRow, SearchItem si);
	
	// 예약 상세
	Appointment appointmentDetail(String resno);
	
	// 진료 내역
	int getTotalCntChart(SearchItem si);
	List<Appointment> consultationListChart(int startRow, int endRow, int type4);

}
