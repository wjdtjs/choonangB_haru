package com.example.haruProject.dao.hr;

import java.util.List;

import com.example.haruProject.dto.Appointment;
import com.example.haruProject.dto.SearchItem;

public interface AppointmentDao {

	// 예약 내역
	int getTotalCnt(SearchItem si);

	List<Appointment> appointmentList(int startRow, int endRow, SearchItem si);

	// 진료 내역
	int getTotalCntChart(SearchItem si);

	List<Appointment> consultationListChart(int startRow, int endRow, SearchItem si);

	// 예약 상세
	Appointment appointmentDetail(String resno);
	// 예악 수정
	int updateReservation(String resno, int rtime, String memo, int status);

}
