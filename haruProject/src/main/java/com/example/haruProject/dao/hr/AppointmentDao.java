package com.example.haruProject.dao.hr;

import java.util.List;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.SearchItem;

public interface AppointmentDao {

	// 예약 내역
	int getTotalCnt(SearchItem si);

	List<Appointment> appointmentList(int startRow, int endRow, SearchItem si);

	// 진료 내역
	int getTotalCntChart();

	List<Appointment> consultationListChart(int startRow, int endRow);

	// 예약 상세
	Appointment appointmentDetail(String resno);

}
